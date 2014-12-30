require 'spec_helper'

RSpec.describe Seminar do
  describe "#get web_notices" do
    it "parses the json" do
      wn = Seminar.new(:web_notices => '[{"title":"name", "value":"gold"}]').get_web_notices
      expect(wn).to eq [{'title' => 'name', 'value' => 'gold'}]
    end
    it "returns empty list on json parse error" do
      # web_notice defaults to nil (not parseable)
      wn = Seminar.new().get_web_notices
      expect(wn).to eq []
    end
  end

  describe "#one_day?" do
    seminar_today = Seminar.new(:name => "today",
                                :date_from => Date.today,
                                :date_to => Date.today)
    seminar_moreday = Seminar.new(:name => "today",
                                  :date_from => Date.today,
                                  :date_to => Date.today + 2)
    it "detects single day events" do
      expect(seminar_today.one_day?).to eq true
      expect(seminar_moreday.one_day?).to eq false
    end
  end
end
