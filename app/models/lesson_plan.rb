class LessonPlan < ActiveRecord::Base
  belongs_to :student
  validates_uniqueness_of :date
  has_many :items, class_name: LessonPlanItem
end
