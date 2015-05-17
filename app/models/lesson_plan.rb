class LessonPlan < ActiveRecord::Base
  belongs_to :student
  validates_uniqueness_of :date
  validates_presence_of :date
  has_many :items, class_name: LessonPlanItem, dependent: :destroy

  def duplicate!(from)
    transaction do
      from.items.each do |item|
        new_item = item.dup
        new_item.save
        self.items << new_item
      end
      self
    end
  end
end
