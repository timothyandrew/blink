module FormGenerator
  class FontCollection
    def initialize(handwritten)
      @handwritten = handwritten
    end

    def fonts
      if @handwritten
        Dir["#{Rails.root}/resources/fonts/handwritten/*ttf"].map do |font_path|
          font_name = File.basename(font_path, ".*")
          Font.new(font_name, font_path)
        end
      else
        [Font.new("Tim", "#{Rails.root}/resources/fonts/OpenSans.ttf")]
      end
    end
  end
end
