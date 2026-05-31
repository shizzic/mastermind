# frozen_string_literal: true

# Secret code handling for mastermind game
class Secret
  attr_reader :code

  def initialize(code_maker)
    self.code = code_maker.make_code
  end

  # gets feedback about input code
  def feedback(turn, input_code, compare_to_code = code)
    "Guess #{turn}: #{input_code.chars.join(' ')}  →  #{detailed_feedback(input_code, compare_to_code)}"
  end

  private

  def detailed_feedback(input_code, compare_to_code)
    chars = compare_to_code.chars

    exact = input_code.chars.zip(chars).count { |a, b| a == b }
    near = (input_code.chars & chars).sum { |c| [input_code.chars.count(c), chars.count(c)].min } - exact

    "#{exact} exact, #{near} near"
  end

  attr_accessor :settings
  attr_writer :code
end
