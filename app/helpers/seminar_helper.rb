# Helper methods defined here can be accessed in any controller or view in the application
module Gusy
  class App
    module SeminarHelper
      # Include these to allow easier spec coverage.
      # Probably there is a cleaner way to get it done.
      include Padrino::Helpers::AssetTagHelpers
      include Padrino::Helpers::TagHelpers
      include Padrino::Helpers::OutputHelpers

      def seminar id_or_shorturl
        Seminar.find(:id => id_or_shorturl) || Seminar.find(:shorturl => id_or_shorturl)
      end
      def seminar_link seminar
        if seminar.shorturl
          link_to seminar.name, url(:seminar, :show, seminar.shorturl)
        else
          link_to seminar.name, url(:seminar, :show, seminar.id)
        end
      end
      def category id_or_shorturl
        Category.find(:id => id_or_shorturl) || Category.find(:shorturl => id_or_shorturl)
      end
      def category_link category
        if category.shorturl
          link_to category.name, url(:seminar, :by_category, category.shorturl)
        else
          link_to category.name, url(:seminar, :by_category, category.id)
        end
      end
    end
    def referee_link referee
      link_to referee.full_name, url(:seminar, :referee, referee.id)
    end

    helpers SeminarHelper
  end
end
