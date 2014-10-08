# Helper methods defined here can be accessed in any controller or view in the application

module Gusy
  class App
    module RegistrationHelper
      def couch_json_registration registration
        reg_json = {
          'firstname' => registration.firstname,
          "lastname"  => registration.lastname,
          "youth"     => [],
          "place"     => registration.city,
          "cellphone" => registration.mobile,
          "num_youth" => "0",
          "zip"       => registration.zip,
          "telephone" => registration.phone,
          "children"  => [],
          "adults"    => [registration.full_name],
          #"g_timestamp": 1406869941,
          "g_type"    => "booking_request",
          "email"     => registration.email,
          "room_wishes" => "", #"Einzelzimmer, Huette, Bauwagen, ",
          "comments"  => registration.comment,
          "num_children" => "0",
          "address"   => registration.street_and_no,
          "l_seminar" => registration.saraswati_seminar_uuid,
          "num_adults" => "1",
          "country"   => registration.country
        }
        # RestClient.push config[saraswati_url]
      end
    end

    helpers RegistrationHelper
  end
end

