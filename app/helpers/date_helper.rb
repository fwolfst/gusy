module Gusy
  class App
    module DateHelper
      # This year as number
      def this_year
        DateTime.now.year
      end
      # Next year
      def next_year
        DateTime.now.year + 1
      end
      # Beginning of this till end of this year
      def this_year_span
        today = Date.today
        [Date.new(this_year,1,1), Date.new(this_year,12,31)]
      end
      # Beginning of this till end of next year
      def this_year_plus_span
        today = Date.today #?
        [Date.new(this_year,1,1), Date.new(this_year + 1,12,31)]
      end
      def three_month
        today = Date.today
        if today.month >= 11
          [Date.new(today.year, today.month, 1), Date.civil(today.year + 1, (today.month + 2) % 12, -1)]
        else
          [Date.new(today.year, today.month, 1), Date.civil(today.year, today.month + 2, -1)]
        end
      end
    end
    helpers DateHelper
  end
end
