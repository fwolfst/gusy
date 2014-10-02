class Category < Sequel::Model
  many_to_many :seminars, :join_table => :seminars_categories
end
