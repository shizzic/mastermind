# frozen_string_literal: true

# Smart strategy for PC in Mastermind game (minimax)
class SmartStrategy
  def initialize(settings)
    self.settings    = settings
    self.colors      = settings.colors
    self.length      = settings.length
    self.duplicates  = settings.duplicates
    self.candidates  = generate_all_codes
    self.last_guess  = nil
  end

  def input(exact:, near:)
    filter_candidates(exact, near) if last_guess

    self.last_guess = candidates.min_by { |code| worst_case_remaining(code) }
    candidates.delete(last_guess)
    last_guess
  end

  private

  attr_accessor :settings, :colors, :length, :duplicates, :candidates, :last_guess

  def generate_all_codes
    if duplicates
      colors.repeated_permutation(length).map(&:join)
    else
      colors.permutation(length).map(&:join)
    end
  end

  def filter_candidates(exact, near)
    candidates.select! { |code| score(code, last_guess) == [exact, near] }
  end

  def score(guess, secret)
    secret_chars = secret.chars
    guess_chars  = guess.chars

    exact = guess_chars.zip(secret_chars).count { |a, b| a == b }
    near  = (guess_chars & secret_chars).sum { |c| [guess_chars.count(c), secret_chars.count(c)].min } - exact

    [exact, near]
  end

  def worst_case_remaining(guess)
    candidates.group_by { |code| score(guess, code) }.values.map(&:size).max
  end
end
