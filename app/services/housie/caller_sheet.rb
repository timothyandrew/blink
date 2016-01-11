module Housie
  class CallerSheet
    COLUMNS = 15
    ROWS = 6
    START = [12, 150]
    SQUARE_SIDE = 50

    def initialize(pdf)
      @pdf = pdf
    end

    def generate
      Utils::PDF.render_title(@pdf, "Caller Sheet")
      @pdf.move_down 200

      x,y = *START
      number = 1
      COLUMNS.times do |c|
        ROWS.times do |r|
          @pdf.stroke_rectangle [x,y], SQUARE_SIDE, SQUARE_SIDE
          @pdf.bounding_box([x,y], width: SQUARE_SIDE, height: SQUARE_SIDE) do
            number = (c + 1 + ((ROWS - r - 1) * COLUMNS))
            @pdf.text number.to_s, align: :center, valign: :center
          end
          number += 1
          y += SQUARE_SIDE
        end
        x += SQUARE_SIDE
        y = START.last
      end
    end
  end
end
