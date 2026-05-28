# frozen_string_literal: true

require_relative 'lib/secret'
require_relative 'lib/player'

# Mastermind cmd game
class Mastermind
  MAX_ATTEMPTS = 12

  def initialize
    self.attempts = MAX_ATTEMPTS
    self.secret   = Secret.new
    self.player   = Player.new
  end

  def start
    explain

    input = ''
    input = try until input == secret.code || attempts.zero?

    if input == secret.code then puts "You won! Number of tries: #{MAX_ATTEMPTS - attempts}"
    else puts 'You lost!'
    end
  end

  private

  attr_accessor :secret, :player, :attempts

  def try
    self.attempts -= 1
    input = player.input(secret.length)
    secret.feedback(MAX_ATTEMPTS - attempts, input)
    input
  end

  # explaining rules of the game
  def explain
    puts "\nWelcome to mastermind game!"
    puts '1. You need to guees 4 length code of uppercase first letters of colors.'
    puts "2. Available colors are: #{Secret::COLORS.join(' ')}"
    puts '3. Your answer should look like (no spaces): BGGR'
    puts '4. I will be helping you with output like: Guess 1: R R G B  →  1 exact, 2 near'
    puts "5. You will have #{attempts} attempts."
    puts "6. Input letters can be downcase. It's irrelevant.\n"
  end
end

Mastermind.new.start
