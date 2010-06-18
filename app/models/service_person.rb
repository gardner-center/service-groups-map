class ServicePerson < ActiveRecord::Base
  belongs_to :service_groups
  has_and_belongs_to_many :programs
end
