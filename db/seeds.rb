def create_sub_goals(goal, student)
  3.times do
    Goal.create(title: Faker::Company.bs, description: Faker::Lorem.paragraph, start: goal.start + 1.day, end: goal.end - 1.day, parent: goal, student_id: student.id)
  end

  if goal.depth < 4
    goal.children.each { |sub_goal| create_sub_goals(sub_goal, student) }
  end
end

def random_time(ordinal)
  hour = sprintf("%02d", (rand * 11).to_i + 1)
  minute = sprintf("%02d", (rand * 59).to_i + 1)
  "#{hour}:#{minute}#{ordinal}"
end

user = User.create(email: "test@example.com", password: "testtest")
1.times { Student.create(name: Faker::Name.name, user: user) }

if Goal.all.empty?
  puts "=> Creating Goals"
  Student.all.each do |student|
    4.times do
      start_date = Faker::Date.forward(50)
      goal = student.goals.create(title: Faker::Company.bs, description: Faker::Lorem.paragraph, start: start_date, end: Faker::Date.between(start_date + 15.days, start_date + 50.days))
      create_sub_goals(goal, student)
    end
  end

  puts "=> Creating Lesson Plans"
  ((Date.today + 10.days) .. (Date.today + 25.days)).each do |date|
    lesson_plan = LessonPlan.create(date: date, user_id: user.id)
    10.times do
      lesson_plan.items.create(start: random_time("am"), end: random_time("pm"), subject: Faker::Commerce.department,
                               topic: Faker::Company.catch_phrase, goals: Faker::Lorem.paragraph,
                               teaching_method: Faker::Lorem.paragraph, teaching_aids: Faker::Lorem.paragraph)
    end
  end
end

if FormGeneratorDataSet.all.empty?
  puts "=> Creating DataSets"
  data_set = FormGeneratorDataSet.create(title: "Names")
  data_set.items.create(text: "Rahul Pai")
  data_set.items.create(text: "Priyanka Kapoor")

  data_set = FormGeneratorDataSet.create(title: "Schools")
  data_set.items.create(text: "Valley School")
  data_set.items.create(text: "Brightlands School")
end
