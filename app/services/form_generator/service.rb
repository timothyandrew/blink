require 'prawn'

module FormGenerator
  class Service
    def initialize(params)
      @form_count = params[:form_count].to_i || 0
      @copy_count = params[:copy_count].to_i || 0
      @fields = params[:fields].map { |_, field| Field.new(field) } || []
      @title = params[:title].presence || "<no title>"
      @handwritten = params[:handwritten].present?
      @pdf = Prawn::Document.new
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

    def generate
      @copy_count.times do |i|
        render_title
        @form_count.times do |j|

          @pdf.move_down(20)
          @pdf.text "#{j+1}.", size: 14
          @pdf.move_down(10)

          @fields.each do |field|
            @pdf.pad_bottom(5) { @pdf.text field.render, size: 12 }
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
