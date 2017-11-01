# frozen_string_literal: true

class Repair < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments
end
