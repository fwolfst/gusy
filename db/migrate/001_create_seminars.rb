Sequel.migration do
  up do
    create_table :seminars do
      primary_key :id
      String :name
      String :shorturl
      String :uuid
      String :thumbnail_url
      DateTime :date_from
      DateTime :date_to
      Text :cancellation_conditions
      Text :description
      Text :description_short
      Text :web_notice
      Text :web_notices
      Boolean :registration_needed
      String :host_email
    end

    create_table :seminars_categories do
      primary_key :id
      foreign_key :seminar_id, :seminars, :on_delete => :cascade
      foreign_key :category_id, :categories, :on_delete => :cascade
    end
  end

  down do
    drop_table :seminars
    drop_table :seminars_categories
  end
end
