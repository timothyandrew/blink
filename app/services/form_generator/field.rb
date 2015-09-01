module FormGenerator
  class Field
    attr_reader :name

    def initialize(attrs)
      @name = attrs[:name].presence || "<no field name>"
      @type = attrs[:type].presence || "<no field type>"
      @dataset = FormGeneratorDataSet.with_title(attrs[:type])
    end

    def value
      item = @dataset.sample
      if item
        item.text
      else
        ""
      end
    end
  end
end
