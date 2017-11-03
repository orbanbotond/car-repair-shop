# frozen_string_literal: true

require "reform/form/dry"

class User::Update < Trailblazer::Operation
  extend Contract::DSL

  contract do
    feature Reform::Form::Dry

    property :id
    property :email
    property :password, readable: false, parse: false

    validation do
      optional(:email).filled(:str?, format?: /.+@.*\./)
    end
  end

  step     :check_params_id!, fail_fast: true
  step     Model(User, :find_by)
  step     Policy::Pundit( UserPolicy, :update? )
  step     Contract::Build()
  step     Contract::Validate()
  step     :save!

  def save!(options, params:, **)
    changed_props = options['contract.default'].changed.map{|k,v| k if v }.compact.map(&:to_sym)
    options['model'].update_attributes options['params'].slice(*changed_props)
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
