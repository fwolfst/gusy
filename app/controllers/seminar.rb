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
  
  get :index do
    @seminars = Seminar.all
    render 'list'
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
      flash.now[:success] = "Showing matching seminars"
    else
      flash.now[:notice] = "Sorry, no hits"

    end
    render 'list'
  end

  get :referee, :with => :id do
    @referee = Referee[params[:id]] || halt(404, "Referee not found")
    render 'referee'
  end

  get :referees do
    @referees = Referee.order(:last_name)
    render 'referees'
  end

  get :register, :with => :id do
    @registration = Registration.new
    @seminar = seminar params[:id]
    render 'registration'
  end
end
