module GoalParsing
  class Parser < Parslet::Parser
    rule(:lparen)     { str('[') }
    rule(:rparen)     { str(']') }
    rule(:newline)    { match['\\r'] >> match['\\n'] }
    rule(:text)       { match['[^\\r\\n\[\]]'].repeat(1) }

    rule(:category)   { lparen >> text.as(:category) >> rparen >> newline }
    rule(:goal)   { text.as(:goal) >> newline.maybe }

    rule(:standalone_goal)   { newline.maybe >> text.as(:goal) >> newline.maybe }
    rule(:category_block) { newline.maybe >> category >> goal.repeat >> newline.maybe }

    rule(:expression) { (category_block.as(:block) | standalone_goal).repeat }
    root :expression
  end
end
