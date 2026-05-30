# frozen_string_literal: true

require_relative 'lib/settings'
require_relative 'lib/player'
require_relative 'lib/secret'

# Mastermind cmd game
class Mastermind
  def initialize
    self.settings = Settings.new
    self.pc       = PC.new(settings)
    self.human    = Human.new(settings)

    choose_player_and_code_maker
  end

  def start
    explain if settings.player == 'Human'

    turn = 0
    code = nil

    loop do
      turn += 1
      code = guess(turn)
      break if secret.code.eql?(code) || turn.eql?(settings.max_guesses)
    end

    puts
    puts code == secret.code ? "You won! Number of guesses: #{turn}" : 'You lost!'
  end

  private

  attr_accessor :settings, :secret, :player, :human, :pc

  def choose_player_and_code_maker
    self.player = settings.player == 'PC' ? pc : human

    # cause code_maker is always opposite from the player
    code_maker  = settings.player == 'PC' ? human : pc
    self.secret = Secret.new(code_maker)
  end

  def guess(turn)
    code = player.input
    secret.feedback(turn, code) unless secret.code.eql?(code)
    code
  end

  # explaining rules of the game
  def explain
    puts <<~TEXT

      Welcome to mastermind game!
      1. Your answer should look like (no spaces): #{pc.make_code.join}
      2. I will be helping you with output like: Guess 1: #{pc.make_code.join(' ')}  →  1 exact, 2 near
      3. Input letters can be downcase. It's irrelevant.
    TEXT
  end
end

Mastermind.new.start
