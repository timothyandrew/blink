class FormGeneratorDataSet < ActiveRecord::Base
  validates_uniqueness_of :title
  validates_presence_of :title
  has_many :items, class_name: FormGeneratorDataSetItem
  accepts_nested_attributes_for :items

  def self.all_titles
    self.all.pluck(:title)
  end

  def import_items(text_lines)
    lines = text_lines.split(/\r?\n/)
    items = lines.map do |line|
      self.items.new(text: line)
    end
    FormGeneratorDataSetItem.import(items)
  end

  def sample
    items.order("RANDOM()").first
  end

  scope :with_title, ->(title) { where("title ILIKE ?", title).first }
end
