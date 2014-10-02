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

  get :by_categories do
    render 'list'
  end

  get :show, :with => :id do
    @seminar = seminar params['id']
    render 'show'
  end

  get :by_date do
    render 'list'
  end

end
