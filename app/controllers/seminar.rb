# encoding: UTF-8
Gusy::App.controllers :seminar do
  before do
    @menu = Gusy::GusyMenu.new
  end

  get :index do
    @title = t('headings.index')
    @categories = Category.all
    render 'index'
  end

  get :current do
    @title = "Sieben Linden: Aktuelle Seminare"
    @menu = Gusy::GusyMenu.current_calendar
    @seminars = Seminar.three_month.all
    render 'list'
  end

  get :calendar do
    @title = "Sieben Linden: Seminarkalender"
    @seminars = Seminar.where{date_from > Date.today}.all
    render 'calendar', :layout => 'iframeable'
  end

  get :all do
    @menu = Gusy::GusyMenu.new
    @menu.all = true
    @seminars = Seminar.all
    render 'list'
  end

  get :list, :with => [:year] do
    @title = "Sieben Linden: Seminare in #{params[:year]}"
    @menu = Gusy::GusyMenu.calendar_year(params[:year].to_i)
    @seminars = Seminar.of_year(params[:year].to_i).all
    render 'list'
  end

  get :list, :with => [:year, :month] do
    @menu = Gusy::GusyMenu.calendar_month(params[:year].to_i,
                                          params[:month].to_i)
    from = DateTime.new(params[:year].to_i, params[:month].to_i, 01)
    to = DateTime.new(params[:year].to_i + 1, params[:month].to_i, 01)
    @seminars = Seminar.of_month(params[:year].to_i, params[:month].to_i).all
    render 'list'
  end

  get :next_3 do
    @seminars = Seminar.where{date_from > Date.today}.limit(3)
    render 'next_3', :layout => 'iframeable'
  end

  get :show, :with => :id_or_shorturl do
    @seminar = seminar(params['id_or_shorturl']) || halt(404, "Seminar not found")
    @title = "Sieben Linden: Seminar #{@seminar.name}"
    render 'show'
  end

  get :by_date do
    @seminars = Seminar.all
    render 'list'
  end

  get :search do
    @title = "Sieben Linden: Seminarsuche"
    @seminars_desc = Seminar.where(Sequel.ilike(:description, "%#{params[:search_term]}%")).all
    @seminars_name = Seminar.where(Sequel.ilike(:name, "%#{params[:search_term]}%")).all
    @seminars = @seminars_desc | @seminars_name
    #Alternative:
    #@seminars = Seminar.grep(:description, "%#{params[:search_term]}%").all
    if !@seminars.empty?
      flash.now[:success] = "#{t('search.show_matches')}: #{params[:search_term]} (#{@seminars.length})"
    else
      flash.now[:notice] = I18n.t('search.no_matches')

    end
    render 'list'
  end

  get :referee, :with => :id do
    @menu = Gusy::GusyMenu.referee
    @referee = Referee[params[:id]] || halt(404, "Referee not found")
    @title = "Sieben Linden Seminare: #{@referee.full_name}"
    render 'referee'
  end

  get :referees do
    @title = "Sieben Linden Seminare: Referentenübersicht"
    @referees = Referee.order(:last_name)
    @menu = Gusy::GusyMenu.referee
    render 'referees'
  end

  get :register, :with => :id do
    @registration = Registration.new
    @seminar = seminar params[:id]
    render 'registration'
  end

  post :register do
    logger.info params
    @seminar = seminar(params['seminar_id']) || halt(404, t("seminars.not_found"))
    @registration = registration_from_params params, @seminar
    @others = params['name'].zip(params['lastname'], params['age']) rescue []
    if !terms_ack? params
      flash.now[:failure] = I18n.t('seminars.need_accept')
    #elsif !participants_valid? @others
    #  flash.now[:failure] = "Teilnehmer-Alter muss eine Zahl sein!"
    elsif @registration.save
      begin
        register! @registration, @seminar
        flash.now[:success] = t('registration.succeeded')
        @registration = nil
        @others = nil
      rescue Exception => e
        flash.now[:failure] = t('registration.real_error')
        logger.error e.inspect
        deliver(:registration_notifier, :error,
                settings.config['notification_address'],
                @registration, @seminar, e)
      end
    else
      logger.warn("Saving registration failed: #{@registration.errors}")
      flash.now[:failure] = t('registration.save_failed')
    end
    render 'show'
  end
end
