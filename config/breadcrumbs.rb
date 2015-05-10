crumb :students do
  link "Students", students_path
end

crumb :student do |student|
  link student.name, student_path(student)
  parent :students
end

crumb :goals do |student|
  link "Goals", student_path(student)
  parent :student, student
end

crumb :goal do |student, goal|
  link goal.title, student_goal_path(student, goal)
  if goal.root?
    parent :goals, student
  else
    parent :goal, student, goal.parent
  end
end

crumb :edit_goal do |student, goal|
  link "Edit", edit_student_goal_path(student, goal)
  parent :goal, student, goal
end

crumb :new_goal do |student, parent_goal|
  if parent_goal
    link "New Goal", new_student_goal_path(student, parent_id: parent_goal.id)
    parent :goal, student, parent_goal
  else
    link "New Long-Term Goal", new_student_goal_path(student)
    parent :goals, student
  end
end
