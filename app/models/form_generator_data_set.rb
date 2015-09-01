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
    transaction do
      lines.each do |line|
        self.items.create!(text: line)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def sample
    items.order("RANDOM()").first
  end

  scope :with_title, ->(title) { where("title ILIKE ?", title).first }
end
