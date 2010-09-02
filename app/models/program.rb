class Program < ActiveRecord::Base
  has_one :service_group
  has_one :repeat
  has_and_belongs_to_many :service_persons
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :styles
  has_many :served_areas
 
  before_validation :capitalize_state
  before_save :create_formatted_address, :get_lat_lon, :create_formatted_characteristics, :hyperlink_url

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
    unless self.address2.nil? || self.address2.blank?
      self.formatted_address += " " + self.address2 + ", "
    else
      self.formatted_address += ", "
    end
    self.formatted_address += self.city + ", " + self.state + ", " + self.zipcode + ", USA"
  end

  def create_formatted_characteristics #JBB Need a script to assign all programs to an existing repeats ID.
    self.formatted_repeats = REPEATS_HASH[self.repeats]
    self.formatted_categories = ""
    self.categories.each_with_index do |category,index|
      self.formatted_categories += category.name
      self.formatted_categories += ", " unless index == self.categories.length - 1
    end
    self.formatted_styles = ""
    self.styles.each_with_index do |style,index|
      self.formatted_styles += style.name
      self.formatted_styles += ", " unless index == self.styles.length - 1
    end
    unless self.start_time.nil? || self.end_time.nil?
      #need to pad zeros or get 16:0
      unless self.start_time > self.end_time
        self.formatted_hours = pretty_time(self.start_time)
        #self.formatted_hours = self.start_time.to_s.gsub(".",":")
        #post_decimal = self.formatted_hours[/\:\d+/]
        #if post_decimal && post_decimal.length == 2
        #  self.formatted_hours += "0"
        #end
        self.formatted_hours += " - "
        self.formatted_hours += pretty_time(self.end_time)
        #self.formatted_hours += " - "
        #self.formatted_hours += self.end_time.to_s.gsub(".",":")
        #post_decimal = end_time.to_s[/\.\d+/]
        #if post_decimal && post_decimal.length == 2
        #  self.formatted_hours += "0"
        #end
      end
    else
      self.formatted_hours = ""
    end
  end

  def hyperlink_url
    unless self.website.blank?
      self.website = "http://" + self.website unless self.website[/^http/]
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

  def pretty_time(time)
    time > 12 ? new_time = time - 12 : new_time = time
    new_time = new_time.to_s
    new_time.gsub!(".",":")
    post_decimal = new_time[/\:\d+/]
    if post_decimal && post_decimal.length == 2
      new_time += "0"
    end
    if time < 12
      new_time += " AM"
    else
      new_time += " PM"
    end
    new_time
  end

end
