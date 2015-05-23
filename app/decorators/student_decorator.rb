class StudentDecorator < Draper::Decorator
  delegate_all

  def short_name
    model.name.split.first
  end
end
