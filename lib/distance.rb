module Distance
#------------------------------------------------
#Takes two lat/lon pairs and a unit specification
#and returns approximate distance between the
#points
#------------------------------------------------

  def distance(lat1,lon1,lat2,lon2,unit)
    #lat1 = lat1.to_f
    #lon1 = lon1.to_f
    #lat2 = lat2.to_f
    #lon2 = lon2.to_f
    theta = lon1 - lon2
    dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta))
    dist = 0.999999999 if dist >= 1 #account for exact address match and rounding complication

    dist = Math.acos(dist)
    dist = rad2deg(dist)
    dist = dist * 60 * 1.515
    if unit == "K"
      dist = dist * 1.609344
    elsif unit == "N"
      dist = dist * 0.8684
    end
    dist
  end

  def deg2rad(deg)
    rad = (deg * Math::PI / 180)
  end

  def rad2deg(rad)
    deg = (rad * 180 / Math::PI)
  end

  ###This method is called anytime a program is created or updated and it uses the google maps API
  ###to insert lat and lon values into the program db record
  def get_lat_lon(address)
    begin
      require 'net/http'

      @geocode = {}
      uri1 = "maps.google.com"
      uri2 = "/maps/api/geocode/json?address=#{address.gsub(/\s/,'+')}&sensor=false"
      json_lat_lon = Net::HTTP.get_response(uri1,uri2)
      @json_lat_lon = ActiveSupport::JSON.decode json_lat_lon.body
      if @json_lat_lon["status"] == "OK"
        @geocode[:lat] = @json_lat_lon["results"][0]["geometry"]["location"]["lat"]
        @geocode[:lon] = @json_lat_lon["results"][0]["geometry"]["location"]["lng"]
      end
    rescue
      @geocode = {}
    end
    @geocode
  end


end
