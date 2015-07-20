# `docx` IEP Template
class IEPTemplate
  def initialize(student)
    @student = student
    @template = Sablon.template(File.expand_path("#{Rails.root}/resources/templates/Baldwins IEP.docx"))
  end

  def generate
    context = {student: @student, subjects: Goal.sort(Goal.roots.where(student_id: @student.id))}
    @template.render_to_string(context)
  end
end
