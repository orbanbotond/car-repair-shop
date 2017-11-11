# frozen_string_literal: true

require "reform/form/dry"

class Comment::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :comment

    validation do
      required(:comment).filled(:str?)
    end
  end

  step     Macro::CheckId(parameter_name: :repair_id), fail_fast: true
  step     :find_repair
  step     :instantiate_new_comment
  step     Policy::Pundit( CommentPolicy, :create? )
  step     Contract::Build()
  step     Contract::Validate()
  step     Contract::Persist()

  def find_repair(options, params:, **)
    repair = Repair.find params[:repair_id]
    options["model.repair"] = repair
  end

  def instantiate_new_comment(options, params:, **)
    options["model"] = options["model.repair"].comments.build
  end
end
