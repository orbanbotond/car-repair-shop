# frozen_string_literal: true

require "reform/form/dry"

class Repair::Update < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :name

    validation do
      required(:name).filled(:str?)
    end
  end

  step     Macro::CheckId(), fail_fast: true
  step     Model(Repair, :find_by)
  step     Policy::Pundit( UserPolicy, :update? )
  step     Contract::Build()
  step     Contract::Validate(), fail_fast: true
  step     Contract::Persist()
end
