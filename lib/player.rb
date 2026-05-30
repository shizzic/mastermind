# frozen_string_literal: true

# Player of mastermind game
class Player
  attr_reader :settings

  def initialize(settings)
    self.settings = settings
  end

  def make_code(_player) = raise notImplementedError
  def input              = raise notImplementedError

  private

  attr_writer :settings
end

require_relative 'player/pc'
require_relative 'player/human'
