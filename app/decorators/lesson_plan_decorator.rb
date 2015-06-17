class LessonPlanDecorator < Draper::Decorator
  delegate_all

  def sorted_items
    model.items.sort_by { |item| item.start || Time.now }
  end
end
