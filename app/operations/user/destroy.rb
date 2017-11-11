# frozen_string_literal: true

require "reform/form/dry"

class User::Destroy < Trailblazer::Operation
  extend Contract::DSL

  step     :check_params_id!, fail_fast: true
  step     Model(User, :find)
  step     Policy::Pundit( UserPolicy, :destroy? )
  step    :destroy_model!

  def destroy_model!(options, params:, **)
    options["model"].destroy
  end

  def check_params_id!(options, params:, **)
    unless params[:id]
      options["params.errors"] = "No ID in params!"
      return false
    end

    unless params[:id].is_a? Numeric
      options["params.errors"] = "The ID is not numeric!"
      return false
    end

    true
  end
end
