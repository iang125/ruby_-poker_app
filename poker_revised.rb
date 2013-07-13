deck = ["1h","2h","3h","4h","5h","6h","7h","8h","9h","10h","11h","12h","13h","1c","2c","3c","4c","5c","6c","7c","8c","9c","10c","11c","12c","13c","1d","2d","3d","4d","5d","6d","7d","8d","9d","10d","11d","12d","13d","1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","11s","12s","13s"]
puts "enter number of players:"
number_of_players = gets.chomp

def play_poker(deck , number_of_players)
  count = 0
  max_bet = 0
  community_cards = []
  used_cards = []
  players = Array.new(number_of_players.to_i) { Hash.new("ferst_card" => "", "second_card" => "", "in_for" => 0,"player_number" => 0, "bet" => 0, "move" => "")}

  players.each_index do |player|
    players[player]["ferst_card"] = deck.sample.to_s
    players[player]["second_card"]= deck.sample.to_s
    used_cards.push(players[player]["ferst_card"])
    used_cards.push(players[player]["second_card"])
    deck.delete(players[player]["ferst_card"] )
    deck.delete(players[player]["second_card"])
    players[player]["player_number"] = player
    puts "player#{player}: |#{players[player]["ferst_card"] }| |#{players[player]["second_card"]}|"
  end

  3.times do |count|
    community_cards[count] = deck.sample.to_s
    used_cards.push(community_cards[count])
    deck.delete(community_cards[count])
  end
  flop = "|#{community_cards[0]}| |#{community_cards[1]}| |#{community_cards[2]}|"
  puts flop
  def calculate_pot_total(players)
    pot = 0
    players.each_index do |player|
      pot = pot + players[player]["in_for"]
    end
  end

  def players_tern(players, player_number, flop)
    puts "player#{player_number} our hand is: |#{players[player_number]["ferst_card"] }| |#{players[player_number]["second_card"]}|"
    puts "and the flop is #{flop}"
    # puts "and the pot is #{pot}"
    puts "what yould you like to do (chack, bet, fold, call):"
    play = gets.chomp
    if play == "chack"
      players[player_number]["move"] = "chack"
    end
    if play == "bet"
      puts "haw much would you like to bet:"
      bet = gets.chomp.to_i
      players[player_number]["move"] = "bet"
    end
    if play == "fold"
      players[player_number]["move"] = "fold"
    end
    if play == "call"
      players[player_number]["bet"] = max_bet
      players[player_number]["move"] = "call"
    end
  end

  def are_all_players_dun(players, max_bet)
    players.each_index do |x|

      if players[x]["move"] == "fold"
        out = true
      end

      if players[x]["move"] != "fold"
        if players[x]["move"] == max_bet
          out = true
        else
          out = false
        end
      end
    end

    return out
  end

  while true
    players.each_index do |player|
      players_tern(players, player, flop)
    end

    if are_all_players_dun(players max_bet) == true
      break
    end
  end
end

play_poker(deck, number_of_players)
