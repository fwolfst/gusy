shell.say "Seeding with test data ..."
# We will create test data here.
seminar_1  = Seminar.create(:name => "Testing Seminar",
                            :date_from => DateTime.new(2014, 12, 31, 9, 9),
                            :date_to => DateTime.new(2015, 01, 01, 10, 10),
                            :shorturl => 'testing_seminar',
                            :uuid => "uuid-like-string",
                            :description => "learn everything you want",
                            :web_notice => '[{"label": "Preis", "text":"10 Euro"}]',
                            :cancellation_conditions => 'no problem, three days before')

category_1 = Category.create(:name => "Soulcleaning",
                             :shorturl => 'soulcleaning',
                             :description => "Ever felt tired?")

seminar_1.add_category category_1
seminar_1.save

seminar_2  = Seminar.create(:name => "Testing Seminar Advanced",
                            :date_from => DateTime.new(2015, 2, 02, 9, 9),
                            :date_to => DateTime.new(2015, 2, 9, 10, 10),
                            :shorturl => 'testing_seminar_advanced',
                            :description => "learn everything you want and more")
seminar_2.add_category category_1
seminar_2.save

seminar_3  = Seminar.create(:name => "Weihnachtsseminar",
                            :date_from => DateTime.new(2014, 12, 24, 9, 9),
                            :date_to => DateTime.new(2015, 01, 01, 10, 10),
                            :shorturl => 'x-mas',
                            :uuid => "uuid-like-string2",
                            :description => "includes cookies"
                            )
seminar_3.save

seminar_4  = Seminar.create(:name => "Vergangenheit erleben",
                            :date_from => DateTime.new(2012, 03, 2, 9, 9),
                            :date_to => DateTime.new(2012, 03, 5, 10, 10),
                            :shorturl => 'pasting',
                            :uuid => "uuid-like-string4",
                            :description => "will be somewhat weird"
                            )
seminar_4.save

referee = Referee.create(:first_name => 'John', :last_name => 'Doe')
referee.add_seminar(seminar_1)
referee.add_seminar(seminar_2)
referee.save
