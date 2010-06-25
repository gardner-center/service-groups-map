class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  def invalid_route
    redirect_to('/visualize', :notice => "Sorry, your request was not recognized")
  end






  private

  def authorize_admin(pwd = "badpwd")
    if session[:admin_user] == "1"
      return true
    elsif pwd == "maldini3!"
      session[:admin_user] = "1"
      return true
    else
      redirect_to("/admin/login", :notice => 'Please login')
    end
  end

end
