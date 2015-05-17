class LessonPlan < ActiveRecord::Base
  belongs_to :student
  validates_uniqueness_of :date
end
