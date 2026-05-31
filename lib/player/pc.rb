# frozen_string_literal: true

# It always must be here to have the abilit to call make_code with random input
require_relative 'pc_strategies/random'

# PC player of mastermind game
class PC < Player
  def initialize(settings)
    super
    self.random = Random.new(settings)

    unless settings.pc_strategy.nil? # rubocop:disable Style/GuardClause
      require_relative "pc_strategies/#{settings.pc_strategy.downcase}"
      self.strategy = Object.const_get(settings.pc_strategy).new(settings)
    end
  end

  def make_code = random.input
  def input(...) = strategy.input(...)

  private

  attr_accessor :strategy, :random
end
