module Housie
  class Column
    include ActiveModel::Validations
    attr_reader :lower, :higher

    validate do |column|
      errors.add(:lower, 'Lower limit must be higher than upper limit') if self.lower > self.higher
      errors.add(:lower, 'Difference between limits must be at least 8') if (self.higher - self.lower) < 8
    end

    def initialize(options)
      @lower = options[:lower].to_i
      @higher = options[:higher].to_i
    end

    def range
      @lower..@higher
    end
  end
end
