Sequel.migration do
  up do
    create_table :seminars do
      primary_key :id
      String :name
      String :shorturl
      DateTime :date_from
      DateTime :date_to
      Text :description
      Text :web_notice
    end

    create_table :seminars_categories do
      primary_key :id
      foreign_key :seminar_id, :seminars
      foreign_key :category_id, :categories
    end
  end

  down do
    drop_table :seminars
    drop_table :seminars_categories
  end
end
