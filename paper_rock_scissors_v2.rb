# Game of Paper Rock Scissors v2 (after correction)
#
# Rewrite program with
# - constant hash for the choices
# - loop on player_choice when the data is incorrect
# - use the "sample" method to get the random data for the computer_choice
# - get out of the loop anytime the answer to "play again" is not "y"
# - !! solve problem in the logic of winner method !!
# - use "&&" instead of "and"
# - rename method winner into winning_pick for more clarity

CHOICES = {"P" => "Paper", "R" => "Rock", "S" => "Scissors"}

# Return the winner between pick 1 and pick 2
def winning_pick(p1, p2)
  if p1 == p2
    return "tie"
  elsif (p1 == "P" && p2 == "R") || (p1 == "R" && p2 == "S") || (p1 == "S" && p2 == "P")
    return p1
  else
    return p2
  end
end

# Display the message to explain why the winner won
def display_message(winner_pick)
  case winner_pick
  when "P"
    puts "Paper wraps Rock!"
  when "R"
    puts "Rock breaks Scissors!"
  when "S"
    puts "Scissors cut Paper!"
  end
end

begin
  # Find my pick and the computer pick
  begin
    puts "Choose one among Paper, Rock, Scissors (P/R/S)"
    my_pick = gets.chomp.upcase
  end until CHOICES.keys.include?(my_pick)
  computer_pick = CHOICES.keys.sample
  puts "You picked #{CHOICES[my_pick]} and computer picked #{CHOICES[computer_pick]}."

  # Determine the winner
  winner_pick = winning_pick(my_pick, computer_pick)
  if winner_pick == "tie"
    puts "It's a tie."
  elsif my_pick == winner_pick
    display_message(winner_pick)
    puts "You won!"
  elsif computer_pick == winner_pick
    display_message(winner_pick)
    puts "Computer won!"
  end
  puts "Play again? (y/n)"
end until gets.chomp.upcase != "Y"
