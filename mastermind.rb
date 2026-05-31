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

    declare(turn, code)
  end

  private

  attr_accessor :settings, :secret, :player, :human, :pc

  def choose_player_and_code_maker
    self.player = settings.player == 'PC' ? pc : human

    # cause code_maker is always the opposite from the player
    code_maker  = settings.player == 'PC' ? human : pc
    self.secret = Secret.new(code_maker)
  end

  def guess(turn)
    code = player.input
    puts
    puts secret.feedback(turn: turn, input_code: code)
    code
  end

  # explaining rules of the game
  def explain
    example_code, example_guess_code = make_example_codes

    puts <<~TEXT

      Welcome to mastermind game!
      1. Your answer should look like (no spaces): #{example_code}
      2. I will be helping you with output like:
         #{secret.feedback(turn: 1, input_code: example_guess_code, compare_to_code: example_code)}
      3. Input letters can be downcase. It's irrelevant.
    TEXT
  end

  def make_example_codes
    example_code       = pc.make_code
    example_guess_code = loop do
      code = pc.make_code
      break code unless example_code.eql?(code)
    end

    [example_code, example_guess_code]
  end

  # declare result of the game
  def declare(turn, code)
    puts
    print settings.player.eql?('PC') ? 'PC' : 'You'
    puts code == secret.code ? " won! Number of guesses: #{turn}" : ' lost!'
    puts
  end
end

Mastermind.new.start
