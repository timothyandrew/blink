class StudentDecorator < Draper::Decorator
  delegate_all

  def short_name
    model.name.split.first
  end

  def sorted_children
    Goal.sort(Goal.roots.where(student_id: model.id).decorate)
  end

  def title
    name
  end
end
