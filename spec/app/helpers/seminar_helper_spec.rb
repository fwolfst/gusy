require 'spec_helper'

RSpec.describe "Gusy::App::SeminarHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend Gusy::App::SeminarHelper }
  subject { helpers }

  it "should return nil" do
    expect(subject.seminar('boo')).to be_nil
  end
end
