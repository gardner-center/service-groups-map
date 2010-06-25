class Zip < ActiveRecord::Base
  has_many :programs

  #Finds the first zip object in the database with the matching zipcode
  #Usage: Zip.code(94305) to return a zip object with zipcode 94305
  def self.code(code)
    first(:conditions => {:code => code})
  end

  def area_for(radius)
    area = {}
    area[:radius] = radius.to_f
    area[:lat_miles] = 69.172 #this is constant
    area[:lon_miles] = (area[:lat_miles] * Math.cos(lat * (Math::PI/180))).abs

    area[:lat_degrees] = radius/area[:lat_miles]  #radius in degrees latitude
    area[:lon_degrees] = radius/area[:lon_miles]  #radius in degrees longitude

    #now set min and max lat and long accordingly
    area[:min_lat] = lat - area[:lat_degrees]
    area[:max_lat] = lat + area[:lat_degrees]
    area[:min_lon] = lon - area[:lon_degrees]
    area[:max_lon] = lon + area[:lon_degrees]    
      
    area
  end
end
