module Gusy
  class App
    module RefereeHelper
      def sort_letter referee
        if referee.last_name
          referee.last_name[0]
        else
          referee.first_name[0]
        end
      end
    end
    helpers RefereeHelper
  end
end
