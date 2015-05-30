# coding: utf-8
module GoalsHelper
  def goal_name_for_depth(depth)
    case depth
    when 0
      "Subject"
    when 1
      "Long Term Goal"
    when 2
      "Short Term Goal"
    when 3
      "Monthly Objective"
    when 4
      "Weekly Objective"
    when 5
      "Activity"
    else
      "Goal"
    end
  end

  def bullet_for_goal(goal, index)
    case goal.depth
    when 0
      ""
    when 1
      "#{RomanNumerals.to_roman(index + 1)}."
    when 2
      "#{index + 1}."
    when 3
      "#{RomanNumerals.to_roman(index + 1).downcase}."
    when 4
      "#{('a'..'z').to_a[index] || '<unknown>'}."
    when 5
      "●"
    else
      "#{index + 1}."
    end
  end
end
