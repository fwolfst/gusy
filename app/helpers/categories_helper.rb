# Helper methods defined here can be accessed in any controller or view in the application

module Gusy
  class App
    module CategoriesHelper
      def get_or_create_category name
        Category.find(:name => name) || Category.create(:name => name)
      end

      # Fetch category by id or shorturl
      def category id_or_shorturl
        Category.find(:id => id_or_shorturl) || Category.find(:shorturl => id_or_shorturl)
      end

      def category_url category
        if category.shorturl
          url(:categories, :show, category.shorturl)
        else
          url(:categories, :show, category.id)
        end
      end

      # HTML link to category (displays name)
      def category_link category
        link_to category.name, category_url(category)
      end
    end

    helpers CategoriesHelper
  end
end
