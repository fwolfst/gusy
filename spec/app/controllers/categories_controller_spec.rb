require 'spec_helper'

RSpec.describe "CategoriesController" do
  describe '/categories/show/soulcleaning' do
    before do
      get "/categories/show/soulcleaning"
    end

    it 'contains the test seminar' do
      expect(last_response.body).to include("Testing Seminar")
    end
    it "containing the category description" do
      expect(last_response.body).to include("Ever felt tired?")
    end
  end

  describe '/categories/list shows overview' do
    before do
      get "/categories/list"
    end

    it "containing the test category" do
      expect(last_response.body).to include("Soulcleaning")
    end

    it "containing the category description" do
      expect(last_response.body).to include("Ever felt tired?")
    end
  end
end
