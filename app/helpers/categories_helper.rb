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
        url(:categories, :show, :category => category.id)
      end

      # HTML link to category (displays name)
      def category_link category
        if category.shorturl
          link_to category.name, url(:categories, :show, category.shorturl)
        else
          link_to category.name, url(:categories, :show, category.id)
        end
      end
    end

    helpers CategoriesHelper
  end
end
