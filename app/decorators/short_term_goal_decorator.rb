class ShortTermGoalDecorator < Draper::Decorator
  delegate_all

  def date_range
    "#{model.start.strftime('%b %-d')} - #{model.end.strftime('%b %-d')}"
  end
end
