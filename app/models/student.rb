class Student < ActiveRecord::Base
  has_many :goals, dependent: :destroy
  validates_presence_of :name
  belongs_to :user

  audited
  has_associated_audits
end
