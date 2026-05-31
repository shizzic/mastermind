# frozen_string_literal: true

# Player of mastermind game
class Player
  attr_reader :settings

  def initialize(settings)
    self.settings = settings
  end

  def make_code                  = raise notImplementedError
  def input(_exact: 0, _near: 0) = raise notImplementedError

  private

  attr_writer :settings
end

require_relative 'player/pc'
require_relative 'player/human'
