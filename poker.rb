cards = ["1h","2h","3h","4h","5h","6h","7h","8h","9h","10h","11h","12h","13h","1c","2c","3c","4c","5c","6c","7c","8c","9c","10c","11c","12c","13c","1d","2d","3d","4d","5d","6d","7d","8d","9d","10d","11d","12d","13d","1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","11s","12s","13s"]
puts "enter number of players:"
number_players = gets.chomp

# cards = {"harts"=>[1,2,3,4,5,6,7,8,9,10,11,12,13],"spades"=>[1,2,3,4,5,6,7,8,9,10,11,12,13],"dimends"=>[1,2,3,4,5,6,7,8,9,10,11,12,13],"clubs"=>[1,2,3,4,5,6,7,8,9,10,11,12,13]}


def play_poker(deck, players)
  max_bet = 0
  used_cards = []
  community_card = []
  # player_hands [player number] [ 0 = ferst card, 1 = second card, 2 = play , 3 = bet amount, 4 = in or ought ]
  player_hands = Array.new(players.to_i) { Array.new(5) }
 #deals ought players hands and removes thare cards from the deck
  players.to_i.times do |count|
    player_hands[count][0] = deck.sample.to_s
    player_hands[count][1] = deck.sample.to_s
    used_cards.push(player_hands[count][0])
    used_cards.push(player_hands[count][1])
    deck.delete(player_hands[count][0])
    deck.delete(player_hands[count][1])
    puts "player#{count}: |#{player_hands[count][0]}| |#{player_hands[count][1]}|"
    player_hands[count][3] = 0
  end
  #creates the flop cards and removes them from the deck
  4.times do |count|
    community_card[count] = deck.sample.to_s
    used_cards.push(community_card[count])
    deck.delete(community_card[count])
  end
  def your_move(player, play)
    puts "player#{player} #{play}"
  end
  def rotation_dun(players, bet, players_in)
    all_players = false
    sum = 0

    players.each do |player|
        sum = sum + player[3]
    end

    if (sum == bet*players_in) and (bet*players_in != 0)
      all_players = true
    end

    if all_players == true
      return true
    end

  end
  flop = "|" + community_card[0].to_s + "|" + "|" + community_card[1].to_s + "|" + "|" + community_card[3].to_s + "|"
  puts flop
  out = 0
  # places last 2 cards and tacks bets
  2.times do |variable|
    puts "make your move players"
    # keeps track of what players are in
    players_in = players.to_i - out
    player = 0
      while true
        # player_hands [player number] [ 0 = ferst card, 1 = second card, 2 = play , 3 = bet amount, 4 = in or ought true=out]
        puts "player#{player} our hand is: |#{player_hands[player][0]}| |#{player_hands[player][1]}|"
        puts "and the flop is #{flop}"
        if max_bet > 0
          puts "some one has bet, you can ether call, fold or rase"
        end
        puts "what yould you like to do:"
        play = gets.chomp
        player_hands[player][2] = play
        if play == "bet" or play == "rase"
          puts "the cerent high bet is #{max_bet}"
          bet = gets.chomp.to_i
          max_bet = max_bet + bet
          player_hands[player][3] = max_bet
          your_move player, play
        elsif play == "call"
          player_hands[player][3] = max_bet
          your_move player, play
        elsif play == "fold"
          player_hands[player][4] = true
          players_in = players_in - 1
          player_hands[player][3] = 0
          your_move player, play
        else
          your_move player, play
        end

        if rotation_dun(player_hands, max_bet, players_in) == true
          puts "you have broken"
          break
        end

        player = player + 1

        if player >= players_in
          player = 0
        end

      end
    flop = flop +"|" + deck.sample.to_s + "|"
    puts flop
  end
end


play_poker cards, number_players

# def pick_random_card(pic_from , number_picked)
#   number_picked.times do |count|
#     random_card = pic_from.sample
#     puts random_card
#   end
# end
