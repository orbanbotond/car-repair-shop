# frozen_string_literal: true

class IndexController < ApplicationController
  before_action :force_authentication

  def welcome
  end
end
