module Housie
  class PlayerSheet
    COLUMNS = 9
    ROWS = 3
    START = [40, 200]
    SQUARE_SIDE = 75

    def initialize(pdf)
      @pdf = pdf
    end

    # Random numbers keyed by row and column; 5 per row, ascending order in column
    def random_numbers
      # Indexes of selected rows for each column
      selected_rows = {}

      # Random number for each [row,column] combination
      final = {}

      # Randomly select (non-blank) columns for each row, and store
      # them in `selected_rows`.
      ROWS.times.each do |row|
        selected_columns = Utils::Rand.rand_n(5, 0...9).sort
        selected_columns.each do |column|
          selected_rows[column] ||= []
          selected_rows[column] << row
        end
      end

      # Generate random numbers for the `selected_rows` in each column, in ascending order
      COLUMNS.times.map do |column|
        rows = selected_rows[column] || []
        to_fill_count = rows.size
        randoms = Utils::Rand.rand_n(to_fill_count, ((column * 10)...((column+1) * 10))).sort
        rows.each_with_index do |row, i|
          final[[row,column]] = randoms[i]
        end
      end

      final
    end

    def generate
      Utils::PDF.render_title(@pdf, "Player Sheet")
      @pdf.move_down 200

      x,y = *START
      numbers = random_numbers

      COLUMNS.times do |c|
        ROWS.times do |r|
          @pdf.stroke_rectangle [x,y], SQUARE_SIDE, SQUARE_SIDE

          row = ROWS - r - 1
          if number = numbers[[row, c]]
            @pdf.bounding_box([x,y], width: SQUARE_SIDE, height: SQUARE_SIDE) do
              @pdf.text number.to_s, align: :center, valign: :center, size: 20
            end
          end

          y += SQUARE_SIDE
        end
        x += SQUARE_SIDE
        y = START.last
      end
    end
  end
end
