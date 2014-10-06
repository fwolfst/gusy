shell.say "Seeding with test data ..."
# We will create test data here.
seminar_1  = Seminar.create(:name => "Testing Seminar",
                            :date_from => DateTime.new(2014, 12, 31, 9, 9),
                            :date_to => DateTime.new(2015, 01, 01, 10, 10),
                            :shorturl => 'testing_seminar',
                            :description => "learn everything you want",
                           :web_notice => '[{"title": "Preis", "value":"10 Euro"}]')

category_1 = Category.create(:name => "Soulcleaning", :shorturl => 'soulcleaning')
seminar_1.add_category category_1
seminar_1.save

seminar_2  = Seminar.create(:name => "Testing Seminar Advanced",
                            :date_from => DateTime.new(2015, 2, 02, 9, 9),
                            :date_to => DateTime.new(2015, 2, 9, 10, 10),
                            :shorturl => 'testing_seminar_advanced',
                            :description => "learn everything you want and more")
seminar_2.add_category category_1
seminar_2.save

referee = Referee.create(:first_name => 'John', :last_name => 'Doe')
referee.add_seminar(seminar_1)
referee.add_seminar(seminar_2)
referee.save
