Gusy::App.controllers :seminar do
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  before do
    @menu = Gusy::GusyMenu.new
  end

  get :index do
    @seminars = Seminar.all
    render 'list'
  end

  get :calendar do
    @seminars = Seminar.where{date_from > Date.today}.all
    render 'calendar', :layout => 'iframeable'
  end

  get :next_3 do
    @seminars = Seminar.where{date_from > Date.today}.limit(3)
    render 'next_3', :layout => 'iframeable'
  end

  get :show, :with => :id do
    @seminar = seminar(params['id']) || halt(404, "Seminar not found")
    render 'show'
  end

  get :by_date do
    @seminars = Seminar.all
    render 'list'
  end

  get :search do
    @seminars = Seminar.where(Sequel.ilike(:description, "%#{params[:search_term]}%")).all
    #Alternative:
    #@seminars = Seminar.grep(:description, "%#{params[:search_term]}%").all
    if !@seminars.empty?
      flash.now[:success] = I18n.t('seminar/show_matches')
    else
      flash.now[:notice] = I18n.t('seminar/no_matches')

    end
    render 'list'
  end

  get :archive, :with => :year, :with => :month do
    @seminars = Seminar.all
    render 'archive'
  end

  get :referee, :with => :id do
    @menu = Gusy::GusyMenu.referee
    @referee = Referee[params[:id]] || halt(404, "Referee not found")
    render 'referee'
  end

  get :referees do
    @referees = Referee.order(:last_name)
    @menu = Gusy::GusyMenu.referee
    render 'referees'
  end

  get :register, :with => :id do
    @registration = Registration.new
    @seminar = seminar params[:id]
    render 'registration'
  end
end
