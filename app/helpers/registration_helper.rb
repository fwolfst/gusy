# Helper methods defined here can be accessed in any controller or view in the application

module Gusy
  class App
    module RegistrationHelper
      def couch_json_registration registration
        if registration.participants_json
          participants = JSON.parse(registration.participants_json)
          adults = participants.select{|p| p[2].to_i > 18}.map{|p| "#{p[0]} #{p[1]}"}
          youths = participants.select{|p| p[2].to_i <= 18 && p[2].to_i > 12}.map{|p| "#{p[0]} #{p[1]}"}
          children = participants.select{|p| p[2].to_i <= 12}.map{|p| "#{p[0]} #{p[1]}"}
          num_adults   = adults.length
          num_children = children.length
          num_youth    = youths.length
        else
          num_adults, num_youth, num_children = 0, 0, 0
          adults, youths, children = [], [], []
        end
        reg_json = {
          'g_value' => {
            'firstname'  => registration.firstname,
            "lastname"   => registration.lastname,
            "youth"      => youths,
            "place"      => registration.city,
            "cellphone"  => registration.mobile,
            "num_youth"  => num_youth,
            "zip"        => registration.zip,
            "telephone"  => registration.phone,
            "children"   => children,
            "adults"     => [registration.full_name] + adults,
#            "g_type"    => "booking_request",
            "email"      => registration.email,
            "room_wishes" => registration.accomodation_json,
            "comments"   => registration.comment,
            "num_children" => num_children,
            "address"    => registration.street_and_no,
            "l_seminar"  => registration.seminar_uuid,
            "num_adults" => num_adults.to_i + 1,
            "country"    => registration.country
          },
          'g_meta' => { 'g_type' => 'slseminar_booking_request' }
        }
        # RestClient.push config[saraswati_url]
      end
    end

    helpers RegistrationHelper
  end
end

