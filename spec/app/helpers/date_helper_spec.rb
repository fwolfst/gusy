require 'spec_helper'

RSpec.describe "Gusy::App::DateHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend Gusy::App::DateHelper }
  subject { helpers }

  describe '#this_year' do
    it 'returns current year' do
      expect(subject.this_year).to eq DateTime.now.year
    end
  end

  describe '#this_year_span' do
    it 'gets this year and next year' do
      expect(subject.this_year_span).to eq [DateTime.now.year, DateTime.now.year + 1]
    end
  end
end
