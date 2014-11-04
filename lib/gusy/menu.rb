require 'ostruct'
module Gusy
  class GusyMenu < OpenStruct
    ACTIVE_CLASS = "active"

    def self.current_calendar
      menu = GusyMenu.new
      menu.seminar_calendar = OpenStruct.new
      menu.seminar_calendar.current = true
      menu
    end
    def self.calendar_year year
      menu = GusyMenu.new
      menu.seminar_calendar = OpenStruct.new
      menu.seminar_calendar.year = year
      menu
    end
    def self.calendar_month year, month
      menu = GusyMenu.new
      menu.seminar_calendar = OpenStruct.new
      menu.seminar_calendar.year = year
      menu.seminar_calendar.month = month
      menu
    end
    def self.categories
      menu = GusyMenu.new
      menu.categories = true
      menu
    end
    def self.referee
      menu = GusyMenu.new
      menu.referees = true
      menu
    end
    def class_calendar
      ACTIVE_CLASS if seminar_calendar
    end
    def class_current
      ACTIVE_CLASS if seminar_calendar.current
    end
    def class_month month
      ACTIVE_CLASS if seminar_calendar.month == month
    end
    def class_year year
      ACTIVE_CLASS if seminar_calendar.year == year
    end
    def has_submenu?
      seminar_calendar
    end
    def class_has_submenu
      "tiered" if has_submenu?
    end
    def class_referees
      ACTIVE_CLASS if referees
    end
    def class_categories
      ACTIVE_CLASS if categories
    end
  end
end
