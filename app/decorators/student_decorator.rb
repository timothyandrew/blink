class StudentDecorator < Draper::Decorator
  delegate_all
  decorates_association :goals
end
