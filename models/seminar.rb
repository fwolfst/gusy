class Seminar < Sequel::Model
  many_to_many :categories, :join_table => :seminars_categories
end
