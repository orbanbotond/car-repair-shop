# frozen_string_literal: true

require "reform/form/dry"

class Repair::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :name

    validation do
      required(:name).filled(:str?)
    end
  end

  step     Model(Repair, :new)
  step     Policy::Pundit(RepairPolicy, :create?)
  step     Contract::Build()
  step     Contract::Validate()
  step     Contract::Persist()
end
