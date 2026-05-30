# frozen_string_literal: true

require 'tty-prompt' # Love the gem

# Settings for mastermind game
class Settings
  attr_reader :max_guesses, :length, :duplicates, :colors, :player

  def initialize = setup

  def valid?(code)
    return false unless code.size == length

    chars = code.chars

    # duplicates check
    return false if !duplicates && chars.uniq.size != chars.size

    # check if code has letters only from available colors
    chars.each { return false unless colors.include?(it) }

    true
  end

  def rules
    puts
    puts <<~TEXT
      1. Available colors: #{colors.join(' ')}
      2. Length: #{length}
      3. Duplicates: #{duplicates ? 'Allowed' : 'Not allowed'}
    TEXT
  end

  private

  attr_writer :max_guesses, :length, :duplicates, :colors, :player

  def setup
    prompt = TTY::Prompt.new
    setup_max_guesses(prompt)
    setup_length(prompt)
    setup_duplicates(prompt)
    setup_colors(prompt)
    setup_player(prompt)
  end

  # how many guesses
  def setup_max_guesses(prompt)
    self.max_guesses = prompt.select('Choose how many guesses will be used:') do |menu|
      menu.choice '6', 6
      menu.choice '8', 8
      menu.choice '10', 10
      menu.choice '12', 12
    end
  end

  # length of the code
  def setup_length(prompt)
    self.length = prompt.select('Choose length of the code:') do |menu|
      menu.choice '3', 3
      menu.choice '4', 4
      menu.choice '5', 5
      menu.choice '6', 6
    end
  end

  # are duplicates allowed?
  def setup_duplicates(prompt)
    self.duplicates = prompt.select('Can the code have duplicates:') do |menu|
      menu.choice 'no', false
      menu.choice 'yes', true
    end
  end

  def setup_colors(prompt)
    self.colors = prompt.multi_select('Choose colors to include:', min: duplicates ? 2 : length) do |menu|
      menu.choice 'Red    (R)', 'R'
      menu.choice 'Blue   (B)', 'B'
      menu.choice 'Green  (G)', 'G'
      menu.choice 'Purple (P)', 'P'
      menu.choice 'Yellow (Y)', 'Y'
      menu.choice 'White  (W)', 'W'
    end

    colors.freeze
  end

  # PC or human
  def setup_player(prompt)
    self.player = prompt.select('Who is maker of the code:') do |menu|
      menu.choice 'PC', 'PC'
      menu.choice 'Player', 'Human'
    end
  end
end
