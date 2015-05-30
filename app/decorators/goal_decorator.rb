class GoalDecorator < Draper::Decorator
  delegate_all

  def strftime_for_depth
    case model.depth
    when 0
      "%b %Y"
    when 1
      "%b %Y"
    when 2
      "%b %Y"
    when 3
      "%b %Y"
    when 4
      "%a, %-d %B %Y"
    when 5
      "%d %b %Y"
    else
      "%d %b %Y"
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
