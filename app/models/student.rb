class Student < ActiveRecord::Base
  has_many :goals
  validates_presence_of :name
  belongs_to :user

  audited
  has_associated_audits
end
