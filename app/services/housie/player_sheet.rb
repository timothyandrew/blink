module Housie
  class PlayerSheet
    START = [40, 200]
    SQUARE_SIDE = 45

    def initialize(pdf, columns, row_count, numbers_per_row)
      @pdf = pdf
      @columns = columns
      @row_count = row_count
      @numbers_per_row = numbers_per_row
    end

    # Random numbers keyed by row and column; 5 per row, ascending order in column
    def random_numbers
      # Indexes of selected rows for each column
      selected_rows = {}

      # Random number for each [row,column] combination
      final = {}

      # Randomly select (non-blank) columns for each row, and store
      # them in `selected_rows`.
      @row_count.times.each do |row|
        selected_columns = Utils::Rand.rand_n(@numbers_per_row, 0...@columns.size).sort
        selected_columns.each do |column|
          selected_rows[column] ||= []
          selected_rows[column] << row
        end
      end

      # Generate random numbers for the `selected_rows` in each column, in ascending order
      @columns.each_with_index do |column, column_i|
        rows = selected_rows[column_i] || []
        to_fill_count = rows.size
        randoms = Utils::Rand.rand_n(to_fill_count, column.range).sort
        rows.each_with_index do |row, row_i|
          final[[row,column_i]] = randoms[row_i]
        end
      end

      final
    end

    def generate
      Utils::PDF.render_title(@pdf, "Player Sheet")
      @pdf.move_down 200

      x,y = *START
      numbers = random_numbers

      @columns.size.times do |c|
        @row_count.times do |r|
          @pdf.stroke_rectangle [x,y], SQUARE_SIDE, SQUARE_SIDE

          row = @row_count - r - 1
          if number = numbers[[row, c]]
            @pdf.bounding_box([x,y], width: SQUARE_SIDE, height: SQUARE_SIDE) do
              @pdf.text number.to_s, align: :center, valign: :center, size: 18
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
