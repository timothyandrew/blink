class GoalDecorator < Draper::Decorator
  delegate_all

  def date_range
    return "" if model.start.blank? or model.end.blank?

    start = model.start.strftime("%b '%y")
    e = model.end.strftime("%b '%y")

    if start == e
      start
    else
      "#{start} - #{e}"
    end
  end
end
