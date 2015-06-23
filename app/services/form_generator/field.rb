require 'dataset'

module FormGenerator
  class Field
    def initialize(attrs)
      @name = attrs[:name].presence || "<no field name>"
      @type = attrs[:type].presence || "<no field type>"
      pick_dataset
    end

    def pick_dataset
      case @type
      when 'name'
        @dataset = DataSet.new(['resources/datasets/first_names.txt', 'resources/datasets/last_names.txt'])
      when 'school'
        @dataset = DataSet.new(['resources/datasets/schools.txt'])
      when 'address'
        @dataset = DataSet.new(['resources/datasets/addresses.txt'])
      when 'blank'
        @dataset = DataSet.new(['resources/datasets/blank.txt'])
      end
    end

    def render
      "#{@name}: #{@dataset.sample}"
    end
  end
end
