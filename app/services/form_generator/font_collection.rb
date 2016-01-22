module FormGenerator
  class FontCollection
    def initialize(handwritten)
      @handwritten = handwritten
    end

    def self.handwritten
      FontCollection.new(true)
    end

    def self.regular
      FontCollection.new(false)
    end

    def self.all_fonts
      self.handwritten.fonts + self.regular.fonts
    end

    def fonts
      if @handwritten
        Dir["#{Rails.root}/resources/fonts/handwritten/*ttf"].map do |font_path|
          font_name = File.basename(font_path, ".*")
          Font.new(font_name, font_path)
        end
      else
        [Font.new("Open Sans", "#{Rails.root}/resources/fonts/OpenSans.ttf")]
      end
    end

    def font
      self.fonts.sample
    end
  end
end
