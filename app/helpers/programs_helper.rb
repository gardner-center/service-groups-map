module ProgramsHelper

  def display_cost(amount = nil)
    if amount.nil?
      @display_value = "Unknown"
    elsif amount == 0
      @display_value = "Free"
    elsif amount > 0
      @display_value = number_to_currency(amount)
    else
      @display_value = "Paid"
    end
  end

  #Turn decminal into friendly time
  def decimal_to_24hour_time(t_value)
    @friendly_time = ft = t_value.to_s
    if ft.length > 0
      @friendly_time = ft[/\d{1,2}/] + ":" 
      ft[/\.(\d{1,2})/]
      @friendly_time += $1.to_s unless $1.nil?
      @friendly_time += "0" if (@friendly_time[/:\d{1,2}/].length == 2)
    end
    @friendly_time
  end

end
