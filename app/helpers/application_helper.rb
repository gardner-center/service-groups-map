module ApplicationHelper

  # not using this, but leaving here as it might be interesting to apply this as an override to the label
  # method in FormBuilder itslef.
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenenceValidator
  end
end
