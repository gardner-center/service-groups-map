class Repeat < ActiveRecord::Base
  belongs_to :programs

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
