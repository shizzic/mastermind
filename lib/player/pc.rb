# frozen_string_literal: true

# PC player of mastermind game
class PC < Player
  def make_code
    colors     = settings.colors
    length     = settings.length
    duplicates = settings.duplicates

    if duplicates
      Array.new(length) { colors.sample }.join
    else
      colors.sample(length).join
    end
  end
end
