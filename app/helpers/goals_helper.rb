module GoalsHelper
  def goal_name_for_depth(depth)
    case depth
    when 0
      "Long Term Goal"
    when 1
      "Short Term Goal"
    when 2
      "Monthly Objective"
    when 3
      "Weekly Objective"
    end
  end
end
