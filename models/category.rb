class Category < Sequel::Model
  many_to_many :seminars, :join_table => :seminars_categories

  #many_to_many :seminars_in_future,
  #  :join_table => :seminars_categories,
  #  :class => Seminar#,
  #  :graph_conditions => {Sequel.function(:higher, :date_from) =>  DateTime.now}

  ## or sub set(:with_seminars_in_future){..}
  dataset_module do
    def future
      where{seminars_dataset.date_from >= DateTime.today}
    end
    def future_seminars
      seminars.where{date_from >= DateTime.today}
    end
  end

  # Retrieves Seminars from future (after now).
  def future_seminars
    seminars_dataset.where{date_from >= DateTime.now}.all
  end

  def current_year_and_later_seminars
    seminars_dataset.where{date_from >= Date.civil(Date.today.year, 1, 1)}.all
  end

  # Retrieves Seminars from the current year.
  def current_year_seminars
    seminars_dataset.where{date_from.year >= DateTime.now.year}.all
  end

  def last_seminar
    seminars_dataset.reverse_order(:date_from).first
  end
end
