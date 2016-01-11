module Housie
  X_BOUND = 780
  Y_BOUND = 575

  class Service
    def initialize(options)
      @pdf = Prawn::Document.new(page_layout: :landscape, page_size: "A4")
      @caller_sheet = CallerSheet.new(@pdf)
      @player_sheets = Array.new(options[:player_count].to_i) { PlayerSheet.new(@pdf) }
    end

    def generate
      @caller_sheet.generate

      @player_sheets.each do |sheet|
        @pdf.start_new_page
        sheet.generate
      end

      @pdf.render
    end
  end
end
