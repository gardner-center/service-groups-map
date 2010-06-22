module ProgramsHelper

  def display_cost(amount)
    amount = amount.to_i
    if amount == 0
      @display_value = "Free"
    elsif amount > 0
      @display_value = number_to_currency(amount)
    else
      @display_value = "Paid"
    end
  end

end
