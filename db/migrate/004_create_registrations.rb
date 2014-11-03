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
      String :participants_json
      String :accomodation_json
      String :comment
      String :seminar_uuid
      String :saraswati_booking_request_uuid
      #Boolean :accept_adress_sharing
      Boolean :accept_future_notice
      #Boolean :accept_ride_sharing
      DateTime :timestamp
    end
  end

  down do
    drop_table :registrations
  end
end
