defmodule Cards do
  @moduledoc """
  Provides methods for creating and dealing cards.
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Diamonds", "Hearts"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Divides the deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> {hand, deck} = Cards.deal(deck, 1)
      iex(3)> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Checks to see if the deck has a specific card in it.

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
  	Enum.member?(deck, card)
  end

  def save(deck, filename) do
  	binary = :erlang.term_to_binary(deck)
  	File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |>Cards.shuffle
    |>Cards.deal(hand_size)
  end
end
