# frozen_string_literal: true

require_relative 'lib/settings'
require_relative 'lib/player'
require_relative 'lib/secret'

# Mastermind cmd game
class Mastermind
  def initialize
    self.settings = Settings.new
    self.player   = settings.player == 'PC' ? PC.new(settings) : Human.new(settings)
    self.secret   = Secret.new(player)
  end

  def start
    explain if settings.player == 'Human'

    turn = 0
    code = nil

    loop do
      turn += 1
      code = guess(turn)
      break if secret.code.eql?(code) || turn == settings.max_guesses
    end

    puts
    puts code == secret.code ? "You won! Number of guesses: #{turn}" : 'You lost!'
  end

  private

  attr_accessor :settings, :secret, :player

  def guess(turn)
    code = player.input
    secret.feedback(turn, code) unless code == secret.code
    code
  end

  # explaining rules of the game
  def explain
    puts <<~TEXT

      Welcome to mastermind game!
      1. Your answer should look like (no spaces): BGGR
      2. I will be helping you with output like: Guess 1: R R G B  →  1 exact, 2 near
      3. Input letters can be downcase. It's irrelevant.
    TEXT
  end
end

Mastermind.new.start
