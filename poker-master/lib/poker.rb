require_relative 'card'
require_relative 'hand'
require_relative 'deck'
require_relative 'player'

class Poker

  def initialize(deck, players)
    @deck = deck
    @players = players
    @pot = 0
  end

  def play
    deck.shuffle
    used_cards = []
    @players.each { |player| player.hand = @deck.draw(5) }
    betting(@players.dup)
    @players.each { |player| used_cards += player.discard(@deck) }
    remaining_players = betting(@players.dup)
    winner = remaining_players.max { |a,b| a.hand <=> b.hand }
    winner.money += @pot
    @pot = 0
    @deck.put_back(used_cards)
    @players.each { |player| @deck.put_back(player.finish_hand) }
  end

  def betting(copy_players)
    bet_amount = 0
    last_raise = copy_players.count
    until last_raise == 0
      initial_bet = copy_players[0].place_bet
      case initial_bet[0]
      when :fold
        copy_players.delete_at(0)
        last_raise -= 1
      when :raise
        last_raise = copy_players.count - 1
        bet_amount += initial_bet[1]
        @pot += copy_players[0].send_money(bet_amount)
        copy_players.rotate!
      when :call
        @pot += copy_players[0].send_money(bet_amount)
        last_raise -= 1
        copy_players.rotate!
      end
    end

    copy_players
  end

  attr_reader :deck, :players, :pot
end
