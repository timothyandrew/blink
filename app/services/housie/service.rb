module Housie
  X_BOUND = 780
  Y_BOUND = 575

  class Service
    include ActiveModel::Validations
    attr_reader :player_count, :columns

    validates_presence_of :player_count
    validates_numericality_of :player_count
    validates_presence_of :columns

    validate do |service|
      errors.add(:columns, 'are invalid') unless self.columns.all?(&:valid?)
    end

    def initialize(options)
      @player_count = options[:player_count].presence
      @columns = (options[:columns] || []).map { |_, attributes| Column.new(attributes) }
    end

    def generate
      @pdf = Prawn::Document.new(page_layout: :landscape, page_size: "A4")
      @caller_sheet = CallerSheet.new(@pdf, @columns)
      @player_sheets = Array.new(@player_count.to_i) { PlayerSheet.new(@pdf, @columns) }
      @caller_sheet.generate

      @player_sheets.each do |sheet|
        @pdf.start_new_page
        sheet.generate
      end

      @pdf.render
    end
  end
end
