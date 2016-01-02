module GoalParsing
  class Transformer
    def initialize(ast)
      @ast = ast
    end

    def transform
      goals = []
      @ast.each do |block_or_goal|
        if block_or_goal[:block]
          category = block_or_goal[:block].select { |items| items[:category].present? }.first[:category].str
          block_or_goal[:block].select { |items| items[:goal].present? }.each do |goal|
            goal = goal[:goal].str
            goals << {category: category, goal: goal}
          end
        else
          goals << {goal: block_or_goal[:goal].str}
        end
      end
      goals
    end
  end
end
