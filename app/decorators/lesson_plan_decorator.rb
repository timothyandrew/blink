class LessonPlanDecorator < Draper::Decorator
  delegate_all

  def sorted_items
    model.items.sort_by { |item| item.start || Time.now }
  end

  def formatted_date
    model.date.strftime("%A | %-d %B %Y")
  end

  def title_date
    model.date.strftime("%-d %B %Y")
  end
end
