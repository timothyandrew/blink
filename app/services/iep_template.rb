# `docx` IEP Template
class IEPTemplate
  def initialize(student)
    @student = student
    @template = Sablon.template(File.expand_path("#{Rails.root}/resources/templates/Baldwins IEP.docx"))
  end

  def generate
    subjects = Goal.sort(Goal.roots.where(student_id: @student.id)).map do |subject|
      grouped_long_term_goals = subject.children.group_by do |goal|
        goal.category_name || "<No Category>"
      end
      should_show_groups = grouped_long_term_goals.keys.count > 1
      {
        title: subject.title,
        ltg: grouped_long_term_goals,
        should_show_groups: should_show_groups,
        should_not_show_groups: !should_show_groups
      }
    end

    context = {student: @student, subjects: subjects}
    @template.render_to_string(context)
  end
end
