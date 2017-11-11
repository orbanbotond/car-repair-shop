# frozen_string_literal: true

require "reform/form/dry"

class User::Update < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :id
    property :email
    property :password, readable: false

    validation do
      optional(:email).filled(:str?, format?: /.+@.*\./)
      # optional(:password).filled
    end
  end

  step     Macro::CheckId(), fail_fast: true
  step     Model(User, :find_by)
  step     Policy::Pundit( UserPolicy, :update? )
  step     Contract::Build()
  step     Contract::Validate()
  step     Contract::Persist()
end
