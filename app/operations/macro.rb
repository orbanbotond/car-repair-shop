module Macro
  def self.CheckId(parameter_name: "id")
    step = ->(input, options) do
      params = options['params']
      unless params[parameter_name]
        options["params.errors"] = "No ID in params!"
        return false
      end

      unless params[parameter_name].is_a? Numeric
        options["params.errors"] = "The ID is not numeric!"
        return false
      end

      true
    end

    [ step, name: "check_param.#{parameter_name}" ]
  end
end