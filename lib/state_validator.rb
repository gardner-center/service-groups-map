class StateValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    begin
      object.errors[attribute] << (options[:message] || "is not a valid U.S. state") unless STATES.has_key?(value.to_sym)
    rescue
      object.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end
