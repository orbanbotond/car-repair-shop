# frozen_string_literal: true

require "reform/form/dry"

class User::Destroy < Trailblazer::Operation
  extend Contract::DSL

  step     Macro::CheckId(), fail_fast: true
  step     Model(User, :find)
  step     Policy::Pundit( UserPolicy, :destroy? )
  step    :destroy_model!

  def destroy_model!(options, params:, **)
    options["model"].destroy
  end
end
