# encoding: UTF-8
require 'spec_helper'

RSpec.describe "Gusy::App::FormatHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend Gusy::App::FormatHelper }
  subject { helpers }

  describe '#param_string' do
    it 'removes non-alphanumeric characters' do
      expect(subject.param_string "Ökoböki?").to eq "_kob_ki_"
    end
  end
end

