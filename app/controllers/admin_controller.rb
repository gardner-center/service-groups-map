class AdminController < ApplicationController

  ssl_required :login, :process_login

  def login

  end

  def process_login
    params[:login].nil? ? authorize_admin("badpw") : authorize_admin(params[:login][:password])
  end

  def invalid_request
    invalid_route
  end

  def logout
    reset_session
    redirect_to("/admin/login")
  end

end
