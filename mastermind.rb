# frozen_string_literal: true

require_relative 'lib/settings'
require_relative 'lib/player'
require_relative 'lib/secret'

# Mastermind cmd game
class Mastermind
  def initialize
    self.settings     = Settings.new
    self.guesses_left = settings.max_guesses
    self.player       = settings.player == 'PC' ? PC.new : Human.new
    self.secret       = Secret.new(settings)
  end

  def start
    explain

    input = ''
    input = guess until input == secret.code || guesses_left.zero?

    if input == secret.code then puts "You won! Number of tries: #{settings.max_guesses - guesses_left}"
    else puts 'You lost!'
    end
  end

  private

  attr_accessor :settings, :secret, :player, :guesses_left

  def guess
    self.guesses_left -= 1
    input = player.input(secret.length)
    secret.feedback(settings.max_guesses - guesses_left, input)
    input
  end

  # explaining rules of the game
  def explain
    puts "\nWelcome to mastermind game!"
    puts '1. You need to guees 4 length code of uppercase first letters of colors.'
    puts "2. Available colors are: #{Secret::COLORS.join(' ')}"
    puts '3. Your answer should look like (no spaces): BGGR'
    puts '4. I will be helping you with output like: Guess 1: R R G B  →  1 exact, 2 near'
    puts "5. You will have #{guesses_left} guesses left."
    puts "6. Input letters can be downcase. It's irrelevant.\n"
  end
end

Mastermind.new.start
