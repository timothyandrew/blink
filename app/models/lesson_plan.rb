class LessonPlan < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :date, scope: :user_id
  validates_presence_of :date, :user
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

  def update_attributes_with_children(attributes, children_attributes)
    children_attributes ||= {}
    children_to_delete = self.items.where.not(id: children_attributes.map { |_, child| child[:id] })
    transaction do
      children_to_delete.destroy_all

      self.assign_attributes(attributes)
      self.save!

      children_attributes.each do |_, child_attributes|
        if child_attributes[:id].present? # Update
          self.items.find_by_id(child_attributes[:id]).update!(child_attributes)
        else
          self.items.build(child_attributes).save!
        end
      end

      self
    end
  rescue ActiveRecord::RecordInvalid
    self.items = self.items.reject { |item| children_to_delete.pluck(:id).include?(item.id) }
    false
  end
end
