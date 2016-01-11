module Utils
  class PDF
    def self.render_title(pdf, title)
      pdf.pad_bottom(10) { pdf.text title, size: 22 }
      pdf.stroke do
        pdf.stroke_color '000000'
        pdf.line_width 2
        pdf.stroke_horizontal_rule
      end
    end
  end
end
