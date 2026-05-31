# frozen_string_literal: true

# Human player of mastermind game
class Human < Player
  def make_code
    settings.rules
    input(creating: true)
  end

  def input(creating: false)
    loop do
      puts
      print creating ? 'Create a code: ' : 'Your guess: '

      code = gets.chomp.strip.upcase
      return code if settings.valid?(code)

      settings.rules
    end
  end
end
