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

  describe "halts for invalid id/shorturl" do
    before do
      get "/seminar/show/no_seminar"
    end

    it "containing the seminar name" do
      expect(last_response.status).to eq(404)
    end
  end

  describe "/seminar/show/:shorturl routes to seminar using short_url" do
    before do
      get "/seminar/show/testing_seminar"
    end

    it "containing the seminar name" do
      expect(last_response.body).to include("Testing Seminar")
    end
  end

  describe "/seminar/show/:id shows seminar details" do
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
    it "containing the seminar description" do
      expect(last_response.body).to include("everything you")
    end
    it "containing notices" do
      expect(last_response.body).to include("Preis")
    end
    it "containing Registration link" do
      expect(last_response.body).to include("Anmeldung")
    end
    it "containing the referee names" do
      expect(last_response.body).to include("John Doe")
    end
    it "shows related seminars" do
      expect(last_response.body).to include("Advanced")
    end
  end

  describe "shows Referee pages" do
    before do
      get '/seminar/referee/1'
    end

    it 'shows the full name' do
      expect(last_response.body).to include('John Doe')
    end
    it 'shows held seminars' do
      expect(last_response.body).to include("Testing Seminar")
      expect(last_response.body).to include("Testing Seminar Advanced")
    end
  end

  describe "shows Referees overview" do
    before do
      get '/seminar/referees'
    end

    it 'shows the full name of referees' do
      expect(last_response.body).to include('John Doe')
    end
  end

  describe 'shows seminar list by date' do
    before do
      get '/seminar/by_date'
    end
    it 'shows the seminars sorted by date, as list' do
      expect(last_response.body).to include("Dezember")
      expect(last_response.body).to include("Februar")
      expect(last_response.body).to include("Testing Seminar")
    end
    it 'therefore should not include the same name twice' do
      expect(last_response.body.scan("Dezember").size).to eq 1
    end
  end

  describe 'shows registration page' do
    before { get '/seminar/register/1' }
    it 'shows the cancellation conditions' do
      expect(last_response.body).to include('three days before')
    end
  end

  pending do
    it 'uses pagination where necessary' do
    end
  end

  pending do
    it 'lets registration fail when terms are not accepted' do
    end
    it 'lets registration fail when wrong seminar is selected' do
    end
    it 'validates the registration' do
    end
    it 'shows flash and success after successfull registration' do
    end
  end
end
