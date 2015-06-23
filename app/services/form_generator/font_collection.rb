module FormGenerator
  class FontCollection
    def initialize(handwritten)
      @handwritten = handwritten
    end

    def fonts
      if @handwritten
        [Font.new("Tim", "#{Rails.root}/resources/fonts/handwritten/Tim.ttf")]
      else
        []
      end
    end
  end
end
