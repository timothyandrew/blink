class LessonPlanItem < ActiveRecord::Base
  belongs_to :lesson_plan
  validates_presence_of :start, :end
  validate :start_time_before_end_time

  audited associated_with: :lesson_plan

  def start_time_before_end_time
    if self.start.present? && self.end.present?
      errors.add(:start, "can't be after end time") if self.start > self.end
    end
  end
end
