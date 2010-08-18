class ServiceGroup < ActiveRecord::Base
  has_many :service_persons
  has_many :programs

  before_validation :capitalize_state
  before_destroy :check_for_actives

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

  def check_for_actives
    if (self.service_persons.count + self.programs.count) > 0
      errors.add_to_base("People and/or programs are still associated with this group, so it cannot be deleted")
      false
    end
  end
end
