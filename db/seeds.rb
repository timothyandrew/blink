# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_sub_goals(goal)
  2.times do
    Goal.create(title: Faker::Company.bs, description: Faker::Lorem.paragraph, start: Faker::Time.forward(23, :morning), end: Faker::Time.forward(23, :morning), parent: goal)
  end
  if goal.depth < 4
    goal.children.each { |goal| create_sub_goals(goal) }
  end
end

10.times { Student.create(name: Faker::Name.name) }
Student.all.each do |student|
  2.times do
    student.goals.create(title: Faker::Company.bs, description: Faker::Lorem.paragraph, start: Faker::Time.forward(23, :morning), end: Faker::Time.forward(23, :morning))
    student.goals.each do |goal|
      create_sub_goals(goal)
    end
  end
end
