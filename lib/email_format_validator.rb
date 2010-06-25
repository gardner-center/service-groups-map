class EmailFormatValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    unless value =~ /.*[a-zA-Z0-9-]\@.*[a-zA-Z0-9-]\.[a-zA-Z]{2,}/
      object.errors[attribute] << (options[:message] || "is not formatted properly")
    end
  end

end
