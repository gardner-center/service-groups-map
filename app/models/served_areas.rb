class ServedAreas < ActiveRecord::Base

  #We require formatted address to be strictly a US zip right now
  #and we only use the first 5 digits

  before_save :get_lat_lon

  def get_lat_lon
    begin
      info_from_zip = Zip.find_by_code(self.formatted_address.first(5))
      self.lat = info_from_zip.lat
      self.lon - info_from_zip.lon
    rescue
      errrors.add(:formatted_address, "must be a U.S. zip code")
    end
  end
end
