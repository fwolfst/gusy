require 'spec_helper'

RSpec.describe "Gusy::App::SeminarHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend Gusy::App::SeminarHelper }
  subject { helpers }

  it "should return nil for invalid seminar" do
    expect(subject.seminar('boo')).to be_nil
  end

  pending do
    it "should make a seminar link available, preferably shorturl" do
      expect(subject.seminar_link subject.seminar(1)).to include "short"
    end
  end
end
