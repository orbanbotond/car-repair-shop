# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  context "fields" do
    it { is_expected.to respond_to(:comment) }
  end

  context "associations" do
    it { is_expected.to belong_to(:repair) }
  end
end
