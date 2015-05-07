crumb :students do
  link "Students", students_path
end

crumb :student do |student|
  link student.name, student_path(student)
  parent :students
end

crumb :long_term_goals do |student|
  link "Long-Term Goals", student_long_term_goals_path(student)
  parent :student, student
end

crumb :long_term_goal do |student, long_term_goal|
  link long_term_goal.name, student_long_term_goal_path(student, long_term_goal)
  parent :long_term_goals, student
end

crumb :short_term_goals do |student, long_term_goal|
  link "Short-Term Goals", student_long_term_goal_short_term_goals_path(student, long_term_goal)
  parent :long_term_goal, student, long_term_goal
end

crumb :short_term_goal do |student, long_term_goal, short_term_goal|
  link short_term_goal.name, student_long_term_goal_short_term_goal_path(student, long_term_goal, short_term_goal)
  parent :short_term_goals, student, long_term_goal
end
