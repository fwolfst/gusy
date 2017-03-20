# encoding: utf-8
Gusy::App.controllers :categories do
  before do
    @menu = Gusy::GusyMenu.categories
  end

  get :show, :with => :category do
    @category = category(params['category']) || halt(404, "Category not found")
    @title = "#{t('seminars.seminars_of_category_title')} #{@category.name} - Ökodorf Sieben Linden"
    render 'show'
  end

  get :list do
    @title = t('categories.list_heading')
    @categories = Category.all
    @categories.reject!{|c| c.name.to_s.strip == '' }
    render 'list'
  end

  get :index do
    redirect 'categories/list'
  end
end
