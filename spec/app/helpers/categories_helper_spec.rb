require 'spec_helper'

RSpec.describe "Gusy::App::CategoriesHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend Gusy::App::CategoriesHelper }
  subject { helpers }

  pending "make url (from router) available in helper" do
    describe "#seminar_url" do
      it 'preferes to link to shorturl' do
        expect(subject.seminar_url(seminar)).to eq ""
      end
      it 'falls back to id' do
        expect(subject.seminar_url(seminar)).to eq ""
      end
    end
  end
end
