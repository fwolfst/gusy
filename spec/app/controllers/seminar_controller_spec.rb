require 'spec_helper'

RSpec.describe "SeminarController" do
  describe "shows basic seminar list (with seminar) as index" do
    before do
      get "/seminar/"
    end
  
    it "contains the test seminar" do
      expect(last_response.body).to include("Testing Seminar")
    end
  end

  describe "shows seminar details" do
    before do
      get "/seminar/show/1"
    end
  
    it "containing the seminar name" do
      expect(last_response.body).to include("Testing Seminar")
    end
    it "containing the seminar categories" do
      expect(last_response.body).to include("Soulcleaning")
    end
    it "containing the seminar date (german format)" do
      expect(last_response.body).to include("31.12.2014")
    end
  end
end
