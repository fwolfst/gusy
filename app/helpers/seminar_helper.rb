# Helper methods defined here can be accessed in any controller or view in the application

module Gusy
  class App
    module SeminarHelper
      def seminar id_or_shorturl
        Seminar.find(:id => id_or_shorturl)
      end
    end

    helpers SeminarHelper
  end
end
