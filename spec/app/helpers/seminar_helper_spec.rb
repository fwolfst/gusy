require 'spec_helper'

RSpec.describe "Gusy::App::SeminarHelper" do
  let(:helpers){ Class.new }
  let(:seminar){ Seminar[1] }
  before { helpers.extend Gusy::App::SeminarHelper }
  subject { helpers }

  describe "#seminar" do
    it "should return nil for invalid seminar" do
      expect(subject.seminar('boo')).to be_nil
    end

    it "should return a seminar based on its short url, id or uuid" do
      s = Seminar[1]
      expect(subject.seminar(1)).to eq s
      expect(subject.seminar("uuid-like-string")).to eq s
      expect(subject.seminar("testing_seminar")).to eq s
    end
  end

  describe "#seminar_year_month" do
    it "returns an array of year, month of start time of seminar" do
      expect(subject.seminar_year_month(subject.seminar(1))).to eq [2014, 12]
    end
  end

  describe "#from_to_format" do
    it 'collapses day, month and year if same month' do
      expect(subject.from_to_format(subject.seminar(2))).to eq "2. - 09.02.2015"
    end
    it 'does not collapses day, month and year if spanning years' do
      expect(subject.from_to_format(subject.seminar(1))).to eq "31.12.2014 - 01.01.2015"
    end
    it 'collapses year if same year' do
      expect(subject.from_to_format(subject.seminar(3))).to eq "24.12.2014 - 01.01.2015"
    end
  end

  pending "need to make url (from router) available in helper""need to make url (from router) available in helper"  do
    describe "#seminar_url" do
      it 'preferes to link to shorturl' do
        expect(subject.seminar_url(seminar)).to eq ""
      end
    end

    it "should make a seminar link available, preferably shorturl" do
      expect(subject.seminar_link subject.seminar(1)).to include "short"
    end
  end
end
