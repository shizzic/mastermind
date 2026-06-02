# frozen_string_literal: true

# Smart strategy for PC in Mastermind game
class Smart
  def initialize(settings)
    self.settings = settings
    self.tried    = []

    self.colors     = settings.colors
    self.length     = settings.length
    self.duplicates = settings.duplicates
  end

  def input(exact:, near:)
    if duplicates
      Array.new(length) { colors.sample }.join
    else
      colors.sample(length).join
    end
  end

  private

  attr_accessor :settings, :tried, :color, :length, :duplicates
end
