class ServicePerson < ActiveRecord::Base
  belongs_to :service_groups
  has_and_belongs_to_many :programs

  validates_associated :service_groups
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, :email_format => true
  
end
