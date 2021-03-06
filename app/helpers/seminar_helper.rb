# Helper methods defined here can be accessed in any controller or view in the application
module Gusy
  class App
    module SeminarHelper
      # Include these to allow easier spec coverage.
      # Probably there is a cleaner way to get it done.
      include Padrino::Helpers::AssetTagHelpers
      include Padrino::Helpers::TagHelpers
      include Padrino::Helpers::OutputHelpers

      # Finds seminar by id, shorturl or uuid
      def seminar id_or_shorturl
        Seminar.find(:id => id_or_shorturl) || Seminar.find(:shorturl => id_or_shorturl) || Seminar.find(:uuid => id_or_shorturl)
      end

      # Return HTML for a link to seminar (with name)
      def seminar_link seminar
        if seminar.shorturl
          link_to seminar.name, url(:seminar, :show, seminar.shorturl)
        else
          link_to seminar.name, url(:seminar, :show, seminar.id)
        end
      end

      # Returns [year, month] of date_from from seminar
      def seminar_year_month seminar
        [seminar.date_from.year, seminar.date_from.month]
      end

      def referee_link referee
        link_to referee.full_name, url(:seminar, :referee, referee.id)
      end

      def from_to_format seminar
        def same_day? from,to
        end
        def same_year? from, to
          from.year == to.year
        end
        def same_month? from, to
          from.month == to.month && same_year?(from, to)
        end
        if same_month? seminar.date_from, seminar.date_to
          "#{seminar.date_from.day}. - #{I18n.l(seminar.date_to, :format => :short)}"
        elsif !same_year? seminar.date_from, seminar.date_to
          "#{I18n.l(seminar.date_from, :format => :short)} - #{I18n.l(seminar.date_to, :format => :short)}"
        else
          "#{I18n.l(seminar.date_from, :format => :daymonth)} - #{I18n.l(seminar.date_to, :format => :short)}"
        end
      end

      def seminar_url seminar
        if seminar.shorturl
          url(:seminar, :show, seminar.shorturl)
        else
          url(:seminar, :show, seminar.id)
        end
      end

      def i18n_short_to seminar
        I18n.l(seminar.date_to, :format => :short)
      end

      def i18n_short_from seminar
        I18n.l(seminar.date_from, :format => :short)
      end

    end

    helpers SeminarHelper
  end
end
