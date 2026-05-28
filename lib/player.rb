# frozen_string_literal: true

require_relative 'secret'

# Player of mastermind game
class Player
  def input(length)
    print "\nYour input: "
    input_value = gets.chomp.strip.upcase
    return input_value if length == input_value.size && input_value.chars.all? { Secret::COLORS.include?(it) }

    puts "Your input must be exectly #{length} long and contain only these letters (colors):"
    puts Secret::COLORS.join(' ')
    input(length)
  end
end
