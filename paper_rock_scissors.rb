# Game of Paper Rock Scissors

# Return the winner between pick 1 and pick 2
def winner(p1, p2)
  if p1 == p2
    return "tie"
  elsif (p1 == "P" and p2 == "R")
    puts "Paper wraps Rock!"
    return p1
  elsif (p1 == "R" and p2 == "S")
    puts "Rock breaks Scissors!"
    return p1
  elsif (p1 == "S" and p2 == "P")
    puts "Scissors cut Paper!"
    return p1
  else
    return p2
  end
end

# Change the letter P, R or S into the corresponding word
def word(pick)
  case pick
    when "P"
      "Paper"
    when "R"
      "Rock"
    when "S"
      "Scissors"
  end
end

begin
  puts "Choose one among Paper, Rock, Scissors (P/R/S)"
  my_pick = gets.chomp.upcase
  computer_pick = case rand(1..3)
                    when 1
                      "P"
                    when 2
                      "R"
                    when 3
                      "S"
                    end
  puts "You picked #{word(my_pick)} and computer picked #{word(computer_pick)}."
  winner_pick = winner(my_pick, computer_pick)
  if winner_pick == "tie"
    puts "It's a tie."
  elsif my_pick == winner_pick
    puts "You won!"
  elsif computer_pick == winner_pick
    puts "Computer won!"
  end
  puts "Play again? (Y/N)"
  play = gets.chomp.upcase
end until play == "N"
