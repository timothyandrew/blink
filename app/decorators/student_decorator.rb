class StudentDecorator < Draper::Decorator
  delegate_all
  decorates_association :goals

  def short_name
    model.name.split.first
  end
end
