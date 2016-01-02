module GoalParsing
  class Service
    def self.parse(s)
      goals = Transformer.new(Parser.new.parse(s)).transform
    rescue Parslet::ParseFailed
    end
  end
end
