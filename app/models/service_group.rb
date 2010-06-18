class ServiceGroup < ActiveRecord::Base
  has_many :service_persons
  has_many :programs
end
