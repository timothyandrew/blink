class GoalCategory < ActiveRecord::Base
  has_many :goals, foreign_key: :category_id
end
