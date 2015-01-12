require 'json'
require 'app'
require 'helpers/date_helper'

class Seminar < Sequel::Model
  class DateHelperClass
    include Gusy::App::DateHelper
  end
  @@date_helper = DateHelperClass.new

  many_to_many :categories, :join_table => :seminars_categories
  many_to_many :referees, :join_table => :seminars_referees

  # json parse the web notice array
  def get_web_notices
    JSON.parse web_notices rescue []
  end

  def one_day?
    date_from.month == date_to.month && date_from.day == date_to.day
  end

  def spans_month?
    date_from.month < date_to.month
  end

  # Scoped by time.
  dataset_module do
    def in_this_year_or_later
      where{date_from >= Date.civil(Date.today.year, 1, 1)}
    end
    def in_this_year
      year_begin, year_end = @@date_helper.this_year_span()
      where{date_from >= year_begin && date_from <= year_end}
    end
    def in_future
      where{date_from >= Date.today}
    end
    def in_nearer_future
      year_begin, year_end = @@date_helper.this_year_span()
      where{date_from >= year_begin && date_from <= year_end}
    end
    def three_month
      span_begin, span_end = @@date_helper.three_month
      where{date_from >= span_begin}.and{date_from <= span_end}
    end
    def of_year year
      where{date_from >= Date.civil(year, 1, 1)}.and{
           date_from <= Date.civil(year + 1, 12, 31)}
    end
    def of_month year, month
      where{date_from >= Date.civil(year, month, 1)}.and{
           date_from <= Date.civil(year, month, -1) + 1}
    end
  end
end
