if ENV['RACK_ENV'] == 'test'
  shell.say "hallo, will seed (in test env)"
  # We will create test data here.
  seminar_1  = Seminar.create(:name => "Testing Seminar",
                              :date_from => DateTime.new(2014, 12, 31, 9, 9),
                              :date_to => DateTime.new(2015, 01, 01, 10, 10))

  category_1 = Category.create(:name => "Soulcleaning")
  seminar_1.add_category category_1
  seminar_1.save
else
  shell.say "No seeds in non-test environment."
end
