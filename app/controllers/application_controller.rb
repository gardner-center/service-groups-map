class ApplicationController < ActionController::Base

  include SslRequirement

  protect_from_forgery
  layout 'application'

  def ssl_required?
    return false if request.remote_ip != "127.0.0.1" || RAILS_ENV == 'test'
  end

  def invalid_route
    redirect_to('/visualize', :notice => "Sorry, your request was not recognized")
  end

  def establish_session 
    begin
      if session[:user_zip].empty? || (session[:expires_at] < Time.now.utc)
        if session[:user_zip].empty?
          session[:user_zip] = HOME_ZIP
          session[:lat] = HOME_LAT
          session[:lon] = HOME_LON
        end
        session[:expires_at] = Time.now.utc + 3.months
      end
    rescue
      if session[:user_zip].empty?
        session[:user_zip] = HOME_ZIP
        session[:lat] = HOME_LAT
        session[:lon] = HOME_LON
      end
      session[:expires_at] = Time.now.utc + 3.months
    end
    if session[:lat].nil? 
      zip = Zip.find_by_code(session[:user_zip])
      session[:lat] = zip.lat
      session[:lon] = zip.lon
    end
    @user_lat = session[:lat]
    @user_lon = session[:lon]
    @change_zip_problem = false
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
