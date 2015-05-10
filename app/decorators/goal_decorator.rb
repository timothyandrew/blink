class GoalDecorator < Draper::Decorator
  delegate_all

  def strftime_for_depth
    case model.depth
    when 0
      "%b %y"
    when 1
      "%b %y"
    when 2
      "%b %y"
    when 3
      "%a, %-d %B %y"
    when 4
      "%d %b %y"
    else
      "%d %b %y"
    end
  end

  def date_range
    return "" if model.start.blank? or model.end.blank?
    start = model.start.strftime(strftime_for_depth)
    e = model.end.strftime(strftime_for_depth)
    "#{start} - #{e}"
  end

  def expanded_date_range
    "#{model.start.strftime("%d %b %Y")} - #{model.end.strftime("%d %b %Y")}"
  end
end
