class ServicePerson < ActiveRecord::Base
  belongs_to :service_groups
  has_and_belongs_to_many :programs

  validates_associated :service_groups
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, :email_format => true
 
  #You are allowed to delete a person who is associated with a program
  #If this is undesirable, then see logic in category and style controllers
  #for adding a check to prevent this
  
end
