Gusy::App.controllers :categories do
  before do
    @menu = Gusy::GusyMenu.categories
  end

  get :show, :with => :category do
    @category = category(params['category']) || halt(404, "Category not found")
    render 'show'
  end

  get :list do
    @categories = Category.all
    render 'list'
  end

  get :index do
    redirect 'categories/list'
  end
end
