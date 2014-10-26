require 'spec_helper'

RSpec.describe Category do
  describe '#future_seminars' do
    it 'gets seminars in the future only' do
      category = Category.find(:name => "Soulcleaning")
      # This will become "1" after march 2015
      expect(category.future_seminars.length).to eq 3
      expect(subject.future_seminars.map(&:title)).to contain("Sci-Fi")
    end
  end
end
