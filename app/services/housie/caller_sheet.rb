module Housie
  class CallerSheet
    ROW_SIZE = 15
    START = [0, 400]
    SQUARE_SIDE = 50

    def initialize(pdf, columns)
      @pdf = pdf
      @columns = columns
    end

    def generate
      Utils::PDF.render_title(@pdf, "Caller Sheet")
      @pdf.move_down 200

      x,y = *START
      number = 1

      row_count = 0
      @columns.each do |column|
        (column.lower..column.higher).each do |number|
          @pdf.stroke_rectangle [x,y], SQUARE_SIDE, SQUARE_SIDE
          @pdf.bounding_box([x,y], width: SQUARE_SIDE, height: SQUARE_SIDE) do
            @pdf.text number.to_s, align: :center, valign: :center
          end

          x += SQUARE_SIDE
          row_count += 1

          if row_count == ROW_SIZE
            row_count = 0
            x, _ = *START
            y -= SQUARE_SIDE
          end
        end
      end
    end
  end
end
