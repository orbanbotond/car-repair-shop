# frozen_string_literal: true

require "reform/form/dry"

class User::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :email
    property :password, readable: false

    validation do
      required(:email).filled(:str?, format?: /.+@.*\./)
      required(:password).filled
    end
  end

  step     Model(User, :new)
  step     Policy::Pundit(UserPolicy, :create?)
  step     Contract::Build()
  step     Contract::Validate()
  step     Contract::Persist()
end
