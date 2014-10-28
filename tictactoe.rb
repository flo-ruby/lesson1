require "pry"
# 1. Draw a grid with 9 places, with the X's and O's given
#     Combination of drawing blank lines, lines with symbols and separation lines
# 2. Ask for player's choice and draw (X)
# 3. Algorithm for computer's choice and draw (O)
#     Easy: random pick where the position is empty
#     Harder: choose a position that:
#         - blocks the player from making a row of X's
#         - helps making a row of O's
# 4. Loop until a row of 3 X's or 3 O's is made, or until all 9 positions are filled
# To define: how to store the X's and O's? array, by default it is " " is the position was not picked yet

# Draw a grid that looks like this depending on X's and O's given
#  puts "     |     |     "
#  puts "  X  |     |     "
#  puts "     |     |     "
#  puts "-----+-----+-----"
#  puts "     |     |     "
#  puts "     |  O  |     "
#  puts "     |     |     "
#  puts "-----+-----+-----"
#  puts "     |     |     "
#  puts "     |     |     "
#  puts "     |     |     "

def draw_line(p = [" "," "," "])
  puts "  #{p[0]}  |  #{p[1]}  |  #{p[2]}  "
end

def draw_separator
  puts "-----+-----+-----"
end

def draw_grid(plays)
  # Clear the screen
  system "clear" or system "cls"

  # Draw the grid
  draw_line
  draw_line(plays[0..2])
  draw_line
  draw_separator
  draw_line
  draw_line(plays[3..5])
  draw_line
  draw_separator
  draw_line
  draw_line(plays[6..8])
  draw_line
end

# Stores the plays, intially " "
plays = Array.new(9) {|i| " "}

draw_grid(plays)
p plays

while plays.include?(" ")
  # Player's choice

  puts "Choose a position (from 1 to 9) to place a piece:"
  begin
    player_choice = gets.chomp
  end until plays[player_choice.to_i - 1] == " "
  plays[player_choice.to_i - 1] = "X"
  draw_grid(plays)

  break unless plays.include?(" ")

  # Computer's choice
  #
  # Easy algorithm:
  # Random pick a position, then check if it is empty, if not try again
  # Or: choose a random position inside an array that is a selection of available positions
  begin
    computer_choice = rand(1..9)
  end until plays[computer_choice - 1] == " "
  plays[computer_choice - 1] = "O"
  draw_grid(plays)

end
