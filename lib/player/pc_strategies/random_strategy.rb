# frozen_string_literal: true

# Random strategy for PC in Mastermind game
class RandomStrategy
  def initialize(settings)
    self.settings = settings
  end

  def input(...)
    colors     = settings.colors
    length     = settings.length
    duplicates = settings.duplicates

    if duplicates
      Array.new(length) { colors.sample }.join
    else
      colors.sample(length).join
    end
  end

  private

  attr_accessor :settings
end
