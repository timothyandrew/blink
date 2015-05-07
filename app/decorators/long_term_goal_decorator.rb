class LongTermGoalDecorator < Draper::Decorator
  delegate_all
  decorates_association :short_term_goals

  def date_range
    "#{model.start.strftime('%B %-d %Y')} - #{model.end.strftime('%B %-d %Y')}"
  end
end
