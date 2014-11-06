module Gusy
  class App
    module FormatHelper
      def param_string str
        str.gsub(/[^0-9a-zA-Z]+/i, '_')
      end
    end

    helpers FormatHelper
  end
end
