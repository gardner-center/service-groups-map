class Program < ActiveRecord::Base
  has_one :service_group
  has_one :repeat
  has_and_belongs_to_many :service_persons
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :styles
  has_many :served_areas
 
  before_validation :capitalize_state
  before_save :create_formatted_address, :get_lat_lon, :create_formatted_characteristics

  scope :within_miles_of_zip, lambda{|radius, zip| #this is interesting, but does
                                                   #not work in present form as
                                                   #zip table not associated with 
                                                   #program tables anymore. We don't
                                                   #want zip table associated, so
                                                   #this should be fixed another way


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

  validates_presence_of :service_group_id, :message => "must be selected"
  validates_presence_of :name
  validates_numericality_of :start_time, :less_than_or_equal_to => 24, :allow_blank => true
  validates_numericality_of :end_time, :less_than_or_equal_to => 24, :allow_blank => true #ideally would check if end date same, then make sure later than start_time
  validates_presence_of :end_date, :greater_than_or_equal_to => :start_date
  validate :validate_date_combination
  validates_presence_of :address1
  validates_presence_of :city
  validate :state, :state => true
  validates :zipcode, :length => {:minimum => 5, :maximum => 10}
  validates_associated :styles
  validates_associated :service_persons
  validates_associated :categories

  private

  def validate_date_combination
    begin
      errors.add(:start_date, "can not be after end date") unless self.start_date <= self.end_date
    rescue
      errors.add(:start_date, "may be invalid") 
      errors.add(:end_date, "may be invalid") 
    end
  end

  def capitalize_state
    self.state = self.state.upcase unless self.state.nil?
  end
     

  def within_miles(radius)
    self.class.within_miles_of_zip(radius, zip)
  end

  def create_formatted_address
    self.formatted_address = self.address1
    unless self.address2.nil?
      self.formatted_address += " " + self.address2 + ", "
    else
      self.formatted_address += ", "
    end
    self.formatted_address += self.city + ", " + self.state + ", " + self.zipcode + ", USA"
  end

  def create_formatted_characteristics
    #self.formatted_repeats = REPEATS[self.repeats][:name]
    #self.categories.each_with_index do |cat,index|
      #self.formatted_categories += cat.name
      #self.formatted_categories += ", " unless index == self.categories.length - 1
    #end
    #self.styles.each_with_index do |style,index|
      #self.formatted_styles += style.name
      #self.formatted_styles += ", " unless index == self.styles.length - 1
    #end
    unless self.start_time.nil? || self.end_time.nil?
      unless self.start_time > self.end_time
        #self.formatted_hours = self.start_time.to_s.gsub(".",":")
        #self.formatted_hours += " - "
        #self.formatted_hours += self.end_time.to_s.gsub(".",":")
      end
    end
  end

  ###This method is called anytime a program is created or updated and it uses the google maps API
  ###to insert lat and lon values into the program db record
  def get_lat_lon
    begin
      require 'net/http'
      uri1 = "maps.google.com"
      uri2 = "/maps/api/geocode/json?address=#{self.formatted_address.gsub(/\s/,'+')}&sensor=false"
      json_lat_lon = Net::HTTP.get_response(uri1,uri2)
      @json_lat_lon = ActiveSupport::JSON.decode json_lat_lon.body
      if @json_lat_lon["status"] == "OK"
        self.lat = @json_lat_lon["results"][0]["geometry"]["location"]["lat"]
        self.lon = @json_lat_lon["results"][0]["geometry"]["location"]["lng"]
      end
    rescue
      errors.add(:lat, "problem retrieving lat/long")
    end
  end

end
