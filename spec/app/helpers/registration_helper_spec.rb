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
                     :seminar_uuid => "uuid",
                     :email     => "phil.common@internet.de",
                     :comment   => "comment") }
  let(:tougher_sample_registration){
    Registration.new(:firstname => "Phil",
                     :lastname  => "Common",
                     :city     => "Commonsville",
                     :street_and_no => "St 22",
                     :zip       => "12345",
                     :country   => "Ahimsa",
                     :mobile    => "01-02-03-04",
                     :phone     => "0102/0304",
                     :seminar_uuid => "uuid",
                     :email     => "phil.common@internet.de",
                     :comment   => "comment",
                     :participants_json => '[["Mia", "Ohlson", 2],'+
                                           '["Pia",  "Marget", 14],'+
                                           '["Ama",  "Loonio", 24]]') }
  before { helpers.extend Gusy::App::RegistrationHelper }
  subject { helpers }

  pending "json check" do
    it "should return json (string equality check)" do
    end
  end

  describe "#couch_json_registration" do
    it "should return expected json for registration" do
      json_hash = {'g_value' => {
        #"g_timestamp" => 1406869941,
        "firstname" => "Phil",
        "youth"     =>  [],
        "place"     =>  "Commonsville",
        "cellphone" =>  "01-02-03-04",
        "num_youth" =>  0,
        "zip"       => "12345",
        "telephone" => "0102/0304",
        "children"  => [],
        "adults"    => ["Phil Common"],
        "email"     => "phil.common@internet.de",
        "room_wishes" => "",
        "comments"  => "comment",
        "num_children" => 0,
        "address"   => "St 22",
        "l_seminar" => "uuid",
        "num_adults" => 1,
        "lastname"  => "Common",
        "country"   => "Ahimsa"
      },
      'g_meta' => {'g_type' => 'slseminar_booking_request'}}

      expect(subject.couch_json_registration(sample_registration)).to eql json_hash
    end

    it "counts children, youth and adults" do
      couch_json = subject.couch_json_registration(tougher_sample_registration)

      expect(couch_json['g_value']['num_children']).to eql 1
      expect(couch_json['g_value']['num_youth']).to eql 1
      expect(couch_json['g_value']['num_adults']).to eql 2
    end

    it "lists children, youth and adults names" do
      couch_json = subject.couch_json_registration(tougher_sample_registration)

      expect(couch_json['g_value']['youth']).to eql ['Pia Marget']
      expect(couch_json['g_value']['children']).to eql ['Mia Ohlson']
      expect(couch_json['g_value']['adults']).to eql ['Phil Common', 'Ama Loonio']
    end
  end
end
