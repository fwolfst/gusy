Sequel.migration do
  up do
    create_table :referees do
      primary_key :id
      String :first_name
      String :last_name
      Text :description
      Text :comment
      String :homepage
      String :image_url
      String :uuid
    end

    create_table :seminars_referees do
      primary_key :id
      foreign_key :seminar_id, :seminars, :on_delete => :cascade
      foreign_key :referee_id, :referees, :on_delete => :cascade
      Text      :qualification_text
    end
  end

  down do
    drop_table :seminars_referees
    drop_table :referees
  end
end
