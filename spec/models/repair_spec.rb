require 'rails_helper'

RSpec.describe Repair do
  context 'fields' do
    it { is_expected.to respond_to(:name) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end