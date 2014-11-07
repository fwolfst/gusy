Sequel.migration do
  up do
    create_table :categories do
      primary_key :id
      String :name
      String :shorturl
      Text :description
      String :image_url
    end
  end

  down do
    drop_table :categories
  end
end
