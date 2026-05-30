# frozen_string_literal: true

require_relative 'player/pc'
require_relative 'player/human'

# Player of mastermind game
class Player
  def make_code = raise notImplementedError
  def input = raise notImplementedError
end
