class StudentDecorator < Draper::Decorator
  delegate_all
  decorates_association :long_term_goals
end
