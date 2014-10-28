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

# A row is made for one of these combinations of X's or O's
# 0 1 2
# 3 4 5
# 6 7 8
# 0 3 6
# 1 4 7
# 2 5 8
# 0 4 8
# 2 4 6
ROWS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

# TODO: put the rows in a winning hash, same for the "almost rows"

# 1. Extract all the indices where we find the given mark
# 2. Check if these indices form one of the patterns above
def row_is_made?(plays, mark)
  # Find all the indices that have a mark, the others will be nil
  ind = plays.map.with_index do |v,i|
    if v == mark
      i
    end
  end
  # Remove the nil values to keep only the indices with a mark
  ind = ind.delete_if {|v| v == nil }
  # Find the rows (if the indices match any of the patterns above)
  r = ROWS.select {|v| v - ind == [] }
  # A row is made if r contains something
  return (r != [])
end

# The goal is to find the cases where we have "almost a row" (2 positions next to each other and the third one is empty)
# The computer can use these insights to block the player from making a row or to make a row
def almost_a_row(plays, mark)
  # Find all the indices that have a mark, the others will be nil
  ind = plays.map.with_index do |v,i|
    if v == mark
      i
    end
  end
  # Remove the nil values to keep only the indices with a mark
  ind = ind.delete_if {|v| v == nil }
  # Find the rows (if the indices match any of the patterns above)
  r = ROWS.map {|v| ind - v }
  almost_rows = r.delete_if {|v| v.size != 2}
end

def grid_is_filled?(plays)
  not plays.include?(" ")
end

# Stores the plays, intially " "
plays = Array.new(9) {|i| " "}

draw_grid(plays)

loop do
  # Player's choice
  puts "Choose a position (from 1 to 9) to place a piece:"
  begin
    player_choice = gets.chomp
  end until plays[player_choice.to_i - 1] == " "
  plays[player_choice.to_i - 1] = "X"
  draw_grid(plays)

  if grid_is_filled?(plays)
    puts "It's a tie."
    break
  end

  if row_is_made?(plays,"X")
    puts "Great job! You won."
    break
  end

  # Computer's choice (easy algo, without IA)
  begin
    computer_choice = rand(1..9)
  end until plays[computer_choice - 1] == " "
  plays[computer_choice - 1] = "O"
  draw_grid(plays)

  if grid_is_filled?(plays)
    puts "It's a tie."
    break
  end

  if row_is_made?(plays,"O")
    puts "The computer won."
    break
  end
end
