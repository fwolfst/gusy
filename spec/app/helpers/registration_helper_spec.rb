require 'spec_helper'

RSpec.describe "Gusy::App::RegistrationHelper" do
  let(:helpers){ Class.new }
  let(:sample_registration){
    Registration.new(:firstname => "Phil",
                     :lastname  => "Common",
                     :city     => "Commonsville",
                     :street_and_no => "St 22",
                     :zip       => "12345",
                     :country   => "Ahimsa",
                     :mobile    => "01-02-03-04",
                     :phone     => "0102/0304",
                     :saraswati_seminar_uuid => "uuid",
                     :email     => "phil.common@internet.de",
                     :comment   => "comment") }
  before { helpers.extend Gusy::App::RegistrationHelper }
  subject { helpers }

  pending "json check" do
    it "should return json (string equality check)" do
    end
  end

  describe "#couch_json_registration" do
    pending "with couch" do
    it "should return expected json for registration" do
      json_hash = {
        #"g_timestamp" => 1406869941,
        "firstname"=> "Phil",
        "youth"     =>  [],
        "place"     =>  "Commonsville",
        "cellphone" =>  "01-02-03-04",
        "num_youth" =>  "0",
        "zip"       => "12345",
        "telephone" => "0102/0304",
        "children"  => [],
        "adults"    => ["Phil Common"],
        "g_type"    => "booking_request",
        "email"     => "phil.common@internet.de",
        "room_wishes" => "",
        "comments" => "comment",
        "num_children" => "0",
        "address"   => "St 22",
        "l_seminar" => "uuid",
        "num_adults" => "1",
        "lastname"  => "Common",
        "country"   => "Ahimsa"
      }

      expect(subject.couch_json_registration(sample_registration)).to eql json_hash
    end
    end
  end
end
