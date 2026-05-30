# frozen_string_literal: true

# Secret code handling for mastermind game
class Secret
  attr_reader :code

  def initialize(settings)
    self.settings = settings
    self.code = settings.code_maker == 'PC' ? make_code_by_pc : 12
  end

  def feedback(guess_num, input)
    puts "Guess #{guess_num}: #{input.chars.join(' ')}  →  #{detailed_feedback(input)}\n"
  end

  private

  def make_code_by_pc
    colors     = settings.colors
    length     = settings.length
    duplicates = settings.duplicates
    duplicates ? Array.new(length) { colors.sample }.join : colors.sample(length)
  end

  def detailed_feedback(input)
    code_arr = code.chars

    exact = input.chars.zip(code_arr).count { |a, b| a == b }
    near = (input.chars & code_arr).sum { |c| [input.chars.count(c), code_arr.count(c)].min } - exact

    "#{exact} exact, #{near} near"
  end

  attr_accessor :settings
  attr_writer :code
end
