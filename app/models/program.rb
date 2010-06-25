class Program < ActiveRecord::Base
  has_one :service_group
  has_one :repeat
  has_and_belongs_to_many :service_persons
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :styles

  validates_presence_of :name
  validates_numericality_of :start_time, :less_than_or_equal_to => 24, :allow_blank => true
  validates_numericality_of :end_time, :less_than_or_equal_to => 24, :allow_blank => true #ideally would check if end date same, then make sure later than start_time
  validates_presence_of :end_date, :greater_than_or_equal_to => :start_date
  validate :validate_date_combination
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state
  validates :zip, :length => {:minimum => 5, :maximum => 10}
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
      
end
