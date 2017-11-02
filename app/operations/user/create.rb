class User::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :email
  end

  step     Model( User, :new )
  step     Contract::Build()
end
