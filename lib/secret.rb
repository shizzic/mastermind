# frozen_string_literal: true

# Secret code handling for mastermind game
class Secret
  attr_reader :code, :near, :exact

  def initialize(code_maker)
    self.code  = code_maker.make_code
    self.near  = 0
    self.exact = 0
  end

  # gets feedback about input code
  def feedback(turn:, input_code:, compare_to_code: code)
    find_near_and_exact(input_code, compare_to_code)
    "Guess #{turn}: #{input_code.chars.join(' ')}  →  #{exact} exact, #{near} near"
  end

  private

  def find_near_and_exact(input_code, compare_to_code)
    chars = compare_to_code.chars

    self.exact = input_code.chars.zip(chars).count { |a, b| a == b }
    self.near = (input_code.chars & chars).sum { |c| [input_code.chars.count(c), chars.count(c)].min } - exact
  end

  attr_writer :code, :near, :exact
end
