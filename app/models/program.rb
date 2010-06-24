class Program < ActiveRecord::Base
  has_one :service_group
  has_one :repeat
  has_and_belongs_to_many :service_persons
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :styles
  belongs_to :zip

  named_scope :within_miles_of_zip, lambda{|radius, zip|

    area = zip.area_for(radius)

    # now find all zip codes that are within 
    # these min/max lat/lon bounds and return them
    # weed out any zip codes that fall outside of the search radius
    { :select => "#{Program.columns.map{|c| "programs.#{c.name}"}.join(', ')}, sqrt( 
        pow(#{area[:lat_miles]} * (zips.lat - #{zip.lat}),2) + 
        pow(#{area[:lon_miles]} * (zips.lon - #{zip.lon}),2)) as distance",
      :joins => :zip,
      :conditions => "(zips.lat BETWEEN #{area[:min_lat]} AND #{area[:max_lat]}) 
        AND (zips.lon BETWEEN #{area[:min_lon]} AND #{area[:max_lon]}) 
        AND sqrt(pow(#{area[:lat_miles]} * (zips.lat - #{zip.lat}),2) + 
        pow(#{area[:lon_miles]} * (zips.lon - #{zip.lon}),2)) <= #{area[:radius]}",
      :order => "distance"}
  }

  def within_miles(radius)
    self.class.within_miles_of_zip(radius, zip)
  end
end
