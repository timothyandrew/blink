module Housie
  class Service
    include ActiveModel::Validations
    attr_reader :player_count, :columns, :row_count, :numbers_per_row

    validates :player_count, presence: true, numericality: true
    validates :row_count, presence: true, numericality: true
    validates :numbers_per_row, presence: true, numericality: true
    validates :columns, presence: true

    validate :columns_must_be_valid
    validate :max_number_of_items_per_row_limited_by_number_of_columns
    validate :each_column_range_should_be_large_enough_to_accomodate_the_row_count

    def initialize(options)
      @player_count = options[:player_count].presence
      @columns = (options[:columns] || []).map { |_, attributes| Column.new(attributes) }
      @row_count = options[:row_count].presence
      @numbers_per_row = options[:numbers_per_row].presence
    end

    def generate
      @pdf = Prawn::Document.new(page_layout: :landscape, page_size: "A4")
      @caller_sheet = CallerSheet.new(@pdf, @columns)
      @player_sheets = Array.new(@player_count.to_i) { PlayerSheet.new(@pdf, @columns, @row_count.to_i, @numbers_per_row.to_i) }
      @caller_sheet.generate

      @player_sheets.each do |sheet|
        @pdf.start_new_page
        sheet.generate
      end

      @pdf.render
    end

    private

    def columns_must_be_valid
      errors.add(:columns, 'are invalid') unless self.columns.all?(&:valid?)
    end

    def max_number_of_items_per_row_limited_by_number_of_columns
      if self.numbers_per_row && self.columns && (self.numbers_per_row.to_i > self.columns.size)
        errors.add(:numbers_per_row, 'cannot be greater than number of columns')
      end
    end

    def each_column_range_should_be_large_enough_to_accomodate_the_row_count
      column_ranges = @columns.map(&:range)
      if column_ranges.any? { |range| range && range.size < @row_count.to_i }
        errors.add(:row_count, "is too large to accomodate the specified ranges of some columns")
      end
    end
  end
end
