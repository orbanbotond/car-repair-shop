# frozen_string_literal: true

require "reform/form/dry"

class User::Update < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :id
    property :email
    property :password

    validation do
      required(:id).filled(:int?)
      optional(:email).filled(:str?, format?: /.+@.*\./)
      optional(:password).filled
    end
  end

  step     Contract::Build()
  step     Model(User, :find_by)
  step     Contract::Validate()
  # step     Contract::Persist()
end
