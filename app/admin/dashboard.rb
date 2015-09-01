ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  content title: "Dashboard" do
    columns do
      column do
        panel "Numbers" do
          table_for [{text: "Goals", number: Goal.count},
                     {text: "Lesson Plans", number: LessonPlan.count},
                     {text: "Students", number: Student.count},
                     {text: "Users", number: User.count}] do
            column("Title") { |data| data[:text] }
            column("Value") { |data| data[:number] }
          end
        end
      end
      column do
        panel "Recent Goals" do
          table_for Goal.last(15) do
            column("Name") { |goal| goal.title }
            column("Student") { |goal| goal.student.name }
            column("Created On") { |goal| goal.created_at }
          end
        end
      end
    end
  end
end
