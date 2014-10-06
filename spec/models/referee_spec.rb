require 'spec_helper'

RSpec.describe Referee do
  it 'combines full name' do
    expect(Referee[1].full_name).to eq('John Doe')
  end
end
