class LessonPlanItemDecorator < Draper::Decorator
  delegate_all

  def span?
    model.subject.present? && model.topic.blank? && model.goals.blank? && model.teaching_method.blank? && model.teaching_aids.blank?
  end

  def range
    "#{model.start.strftime('%-l:%M%P')} - #{model.end.strftime('%-l:%M%P')}"
  end
end
