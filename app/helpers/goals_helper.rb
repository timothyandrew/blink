# coding: utf-8
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
    when 4
      "Activity"
    else
      "Goal"
    end
  end

  def bullet_for_goal(goal, index)
    case goal.depth
    when 0
      "#{RomanNumerals.to_roman(index + 1)}."
    when 1
      "#{index + 1}."
    when 2
      "#{RomanNumerals.to_roman(index + 1).downcase}."
    when 3
      "#{('a'..'z').to_a[index] || '<unknown>'}."
    when 4
      "●"
    else
      "#{index + 1}."
    end
  end
end
