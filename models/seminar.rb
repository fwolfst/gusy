require 'json'

class Seminar < Sequel::Model
  many_to_many :categories, :join_table => :seminars_categories
  many_to_many :referees, :join_table => :seminars_referees
  def web_notices
    JSON.parse web_notice
  end
end
