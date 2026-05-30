# frozen_string_literal: true

# Human player of mastermind game
class Human < Player
  def make_code
    settings.rules
    input
  end

  def input
    loop do
      code = gets.chomp.strip.upcase
      return code if settings.valid?(code)

      settings.rules
    end
  end
end
