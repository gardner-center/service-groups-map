class ServiceGroup < ActiveRecord::Base
  has_many :service_persons
  has_many :programs

  before_validation :capitalize_state

  validates_presence_of :name
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state
  validates :state, :state => true
  validates :zip, :length => {:minimum => 5, :maximum => 10}
  validates_presence_of :inception_date

  def capitalize_state
    self.state = self.state.upcase unless self.state.nil?
  end
end
