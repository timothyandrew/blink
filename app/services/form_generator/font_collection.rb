module FormGenerator
  class FontCollection
    def initialize(handwritten)
      @handwritten = handwritten
    end

    def fonts
      if @handwritten
        [Font.new("Tim", "#{Rails.root}/resources/fonts/handwritten/Tim.ttf"),
         Font.new("Rakshitha", "#{Rails.root}/resources/fonts/handwritten/Rakshitha.ttf")]
      else
        [Font.new("Tim", "#{Rails.root}/resources/fonts/handwritten/OpenSans.ttf")]
      end
    end
  end
end
