# frozen_string_literal: true

# Secret code handling for mastermind game
class Secret
  attr_reader :code

  def initialize(code_maker)
    self.code = code_maker.make_code
  end

  def feedback(turn, p_code)
    puts
    puts "Guess #{turn}: #{p_code.chars.join(' ')}  →  #{detailed_feedback(p_code)}"
  end

  private

  def detailed_feedback(p_code)
    chars = code.chars

    exact = p_code.chars.zip(chars).count { |a, b| a == b }
    near = (p_code.chars & chars).sum { |c| [p_code.chars.count(c), chars.count(c)].min } - exact

    "#{exact} exact, #{near} near"
  end

  attr_accessor :settings
  attr_writer :code
end
