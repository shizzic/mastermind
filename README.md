# Mastermind

A Ruby command-line implementation of the classic code-breaking game, built as part of [The Odin Project](https://www.theodinproject.com/) curriculum.

## How to run

Make sure you have Ruby installed, then clone the repo and install dependencies:

```bash
git clone git@github.com:shizzic/mastermind.git
cd mastermind
bundle install
ruby mastermind.rb
```

## Settings

Before each game you configure:

- **Guesses** — 6, 8, 10, or 12
- **Code length** — 3 to 6
- **Duplicates** — whether the code can repeat colors
- **Colors** — choose which colors are in play (R, B, G, P, Y, W)
- **Who plays** — you guess, or PC guesses

If PC is the guesser, you also choose its strategy:

- **Random** — picks a valid random code each turn
- **Smart** — uses minimax to eliminate candidates and guess optimally

## Gameplay

After each guess you see feedback like:

```
Guess 1: R B G P  →  1 exact, 2 near
```

- **exact** — right color, right position
- **near** — right color, wrong position
