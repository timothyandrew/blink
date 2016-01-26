require 'prawn'
require 'font_collection'

module FormGenerator
  Y_BOUND = 780
  X_BOUND = 575

  class Service
    def initialize(params)
      @form_count = params[:form_count].to_i || 0
      @copy_count = params[:copy_count].to_i || 0
      @student_name = params[:student_name].presence
      @fields = params[:fields].map { |_, field| Field.new(field) } || []
      @title = params[:title].presence || "<no title>"
      @handwritten = ActiveRecord::Type::Boolean.new.type_cast_from_user(params[:handwritten])
      @pdf = Prawn::Document.new(page_layout: :portrait, page_size: "A4")
      @font = FontCollection.new(@handwritten).font
      register_fonts
    end

    def register_fonts
      fonts = FontCollection.all_fonts
      fonts.each do |font|
        @pdf.font_families.update(font.name => { normal: font.path })
      end
    end

    def render_title
      @pdf.pad_bottom(10) { @pdf.text @title, size: 22 }
      @pdf.stroke do
        @pdf.stroke_color '000000'
        @pdf.line_width 2
        @pdf.stroke_horizontal_rule
      end
    end

    def new_page
      @pdf.start_new_page
    end

    def draw_student_name
      @pdf.font(FontCollection.regular.font.name) do
        @pdf.draw_text "Name: _________________________", at: [X_BOUND - 260, Y_BOUND - 25]
      end

      if @student_name
        @pdf.font(FontCollection.handwritten.font.name) do
          @pdf.draw_text "#{@student_name}", at: [X_BOUND - 215, Y_BOUND - 30], size: 22
        end
      end
    end

    def generate
      draw_student_name

      @copy_count.times do |i|
        render_title
        @form_count.times do |j|

          @pdf.move_down(20)
          @pdf.text "#{j+1}.", size: 14
          @pdf.move_down(10)

          font_size = @handwritten ? 22 : 14

          @fields.each do |field|
            @pdf.pad_bottom(5) do
              @pdf.formatted_text [
                {text: "#{field.name}: ", size: 12},
                {text: field.value, size: font_size, font: @font.name}
              ]
            end
          end
          @pdf.move_down(15)

          if j < @form_count - 1
            @pdf.stroke do
              @pdf.stroke_color 'aaaaaa'
              @pdf.line_width 0.5
              @pdf.stroke_horizontal_rule
            end
          end
        end

        if i < @copy_count - 1
          new_page
        end
      end

      @pdf.render
    end
  end
end
