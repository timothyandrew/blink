crumb :students do
  link "Students", students_path
end

crumb :student do |student|
  link student.name, student_path(student)
  parent :students
end

crumb :student_goal_tree do |student|
  link "Goal Tree", tree_student_goals_path(student)
  parent :student, student
end

crumb :goal_tree do |student, goal|
  link "Goal Tree", tree_student_goals_path(student, goal_id: goal)
  parent :goal, student, goal
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

crumb :picture_comprehension_exercises do
  link "Picture Comprehension", picture_comprehension_exercises_path
end

crumb :picture_comprehension_exercise do |pc|
  link pc.name, picture_comprehension_exercise_path(pc)
  parent :picture_comprehension_exercises
end

crumb :picture_comprehension_exercise_play do |pc|
  link "Playing"
  parent :picture_comprehension_exercise, pc
end

crumb :student_notes do |student|
  link "Notes", student_notes_path(student)
  parent :student, student
end

crumb :edit_student_notes do |student|
  link "Edit", edit_student_notes_path(student)
  parent :student_notes, student
end

crumb :general_notes do
  link "General Notes", notes_path
end

crumb :general_note do |note|
  link note.title, note_path(note)
  parent :general_notes
end

crumb :new_general_note do
  link "New", new_note_path
  parent :general_notes
end

crumb :edit_general_note do |note|
  link "Edit", edit_note_path(note)
  parent :general_notes
end

crumb :lesson_plans do
  link "Lesson Plans", lesson_plans_path
end

crumb :lesson_plan do |lesson_plan|
  link lesson_plan.long_date, lesson_plan_path(lesson_plan)
  parent :lesson_plans
end

crumb :new_lesson_plan do
  link "New", new_lesson_plan_path
  parent :lesson_plans
end

crumb :edit_lesson_plan do |lesson_plan|
  link "Edit", new_lesson_plan_path
  parent :lesson_plan, lesson_plan
end

crumb :lesson_plan_item do |lesson_plan, item|
  link item.range, lesson_plan_path(lesson_plan)
  parent :lesson_plan, lesson_plan
end

crumb :new_lesson_plan_item do |lesson_plan|
  link "New Item", new_lesson_plan_item_path(lesson_plan)
  parent :lesson_plan, lesson_plan
end

crumb :edit_lesson_plan_item do |lesson_plan, item|
  link "Edit", edit_lesson_plan_item_path(lesson_plan, item)
  parent :lesson_plan_item, lesson_plan, item
end

crumb :audit_log do |student|
  link "Audit Log", student_audits_path(student)
  parent :student, student
end

crumb :number_name_games do
  link "Number Name Games", number_name_games_path
end

crumb :number_name_game do |game|
  link game.name , number_name_game_path(game)
  parent :number_name_games
end

crumb :play_number_name_game do |game|
  link "Play" , play_number_name_game_path(game)
  parent :number_name_game, game
end
