Sequel.migration do
  up do
    create_table :seminars do
      primary_key :id
      String :name
      DateTime :date_from
      DateTime :date_to
    end

    create_table :seminars_categories do
      primary_key :id
      foreign_key :seminar_id, :seminars
      foreign_key :category_id, :categories
    end
  end

  down do
    drop_table :seminars
  end
end
