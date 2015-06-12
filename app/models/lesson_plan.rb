class LessonPlan < ActiveRecord::Base
  belongs_to :student
  validates_uniqueness_of :date, scope: :user_id
  validates_presence_of :date
  has_many :items, class_name: LessonPlanItem, dependent: :destroy

  audited
  has_associated_audits

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

  def long_date
    self.date.strftime("%A - %-d %B %Y")
  end

  def self.grouped_by_month_and_week
    lesson_plans_grouped_by_month = all.group_by { |lp| lp.date.beginning_of_month }
    lesson_plans_grouped_by_month_and_week = lesson_plans_grouped_by_month.map do |month, lesson_plans|
      [month, lesson_plans.group_by { |lp| lp.date.beginning_of_week }]
    end

    Hash[lesson_plans_grouped_by_month_and_week]
  end

  def save_with_children(attributes, children_attributes)
    transaction do
      self.assign_attributes(attributes)
      children = children_attributes[:items].map { |_, child_attributes| self.items.build(child_attributes) }

      self.save!
      children.each(&:save!)

      self
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
