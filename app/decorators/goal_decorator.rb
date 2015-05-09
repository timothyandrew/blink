class GoalDecorator < Draper::Decorator
  delegate_all

  def date_range
    "#{model.start.strftime('%B %-d %Y')} - #{model.end.strftime('%B %-d %Y')}"
  end
end
