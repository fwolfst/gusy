require 'spec_helper'

RSpec.describe "Gusy::App::RefereeHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend Gusy::App::RefereeHelper }
  subject { helpers }

  describe '#sort_letter' do
    it 'returns last names first letter ' do
      referee = Referee.new(:first_name => "John", :last_name => "Croft")
      expect(subject.sort_letter referee).to eq "C"
    end
    it 'resorts to first names first letter ' do
      referee = Referee.new(:first_name => "Adam")
      expect(subject.sort_letter referee).to eq "A"
    end
  end
end

