# Helper methods defined here can be accessed in any controller or view in the application
require 'rest_client'
require 'securerandom'

module Gusy
  class App
    module RegistrationHelper

      def error_class? registration, field
         return 'error' if registration && registration.errors[field]
      end

      def other_participant_html person
        "<div class='three fields'> "+
          "<div class='field'>"+
            "<p>"+
              "<label for='name'>Vorname</label>"+
              "<input id='name' type='text' name='name[]' value='#{person[0]}'></input>"+
            "</p>"+
          "</div>"+
          "<div class='field'>"+
            "<p>"+
              "<label for='lastname'>Nachname</label>"+
              "<input id='lastname' type='text' name='lastname[]' value='#{person[1]}'></input>"+
            "</p>"+
          "</div>"+
          "<div class='field'>"+
            "<p>"+
              "<label for='age'>Alter</label>"+
              "<input id='age' type='text' name='age[]' value='#{person[2]}'></input>"+
            "</p>"+
          "</div>"+
        "</div>"
      end

      def new_participant_html
        other_participant_html ['', '', '']
      end

      def terms_ack? params
        param_terms_ack = params['registration'].delete 'accept_terms'
        param_terms_ack && param_terms_ack == "on"
      end

      def registration_from_params params, seminar
        Registration.strict_param_setting = false
        params['registration'] ||= {}
        registration = Registration.new params['registration']
        registration.seminar_uuid = seminar.uuid
        registration.accomodation_json = [*params['room_wish']].join(', ')
        others = params['name'].zip(params['lastname'], params['age']) rescue []
        registration.participants_json = others.to_json
        registration
      end

      def register! registration, seminar
        json = couch_json_registration registration
        push_booking_request json.to_json
        deliver(:registration_notifier,
                :confirm_registration,
                settings.config['notification_address'],
                registration, seminar)
        deliver(:registration_notifier,
                :notify_host,
                settings.config['notification_address'],
                registration, seminar)
      end

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
        #"g_timestamp": Time.now.to_i,
      end

      def push_booking_request req_json
        uuid = SecureRandom.uuid
        doc_url = "#{settings.config['saraswati']['couch_url']}/#{uuid}"
        response = RestClient.put(doc_url, req_json,
                                  :content_type => 'application/json')
      end

    end

    helpers RegistrationHelper
  end
end

