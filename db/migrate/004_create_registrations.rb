Sequel.migration do
  up do
    create_table :registrations do
      primary_key :id
      String :firstname
      String :lastname
      String :street_and_no
      String :zip
      String :city
      String :country
      String :email
      String :phone
      String :mobile
      Text :participants_json
      Text :accomodation_json
      String :comment
      Boolean :accept_future_notice
      DateTime :timestamp
      # Seminar and booking request uuid deal with
      # Sieben Linden specific systems.
      String :seminar_uuid
      String :booking_request_uuid
    end
  end

  down do
    drop_table :registrations
  end
end
