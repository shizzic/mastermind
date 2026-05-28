# frozen_string_literal: true

# Secret code handling for mastermind game
class Secret
  COLORS = %w[Y B G P R W].freeze

  attr_reader :code, :length

  def initialize
    self.length = 4
    self.code   = Array.new(4) { COLORS.sample }.join
  end

  def feedback(attempt, input)
    puts "Guess #{attempt}: #{input.chars.join(' ')}  →  #{detailed_feedback(input)}\n"
  end

  private

  def detailed_feedback(input)
    code_arr = code.chars

    exact = input.chars.zip(code_arr).count { |a, b| a == b }
    near = (input.chars & code_arr).sum { |c| [input.chars.count(c), code_arr.count(c)].min } - exact

    "#{exact} exact, #{near} near"
  end

  attr_writer :code, :length
end
