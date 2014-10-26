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
end
