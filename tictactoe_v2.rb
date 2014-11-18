# After correction:
# - rewrite with more methods for more clarity
# - use a hash to store the positions in the grid
# - method with the empty positions
# - change logic in computer pick

# 1. Draw a grid with 9 places, with the X's and O's given
#     Combination of drawing blank lines, lines with symbols and separation lines
# 2. Ask for player's choice and draw (X)
# 3. Algorithm for computer's choice and draw (O)
# 4. Loop until a row of 3 X's or 3 O's is made, or until all 9 positions are filled

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

def draw_line(line = [" "," "," "])
  puts "  #{line[0]}  |  #{line[1]}  |  #{line[2]}  "
end

def draw_separator
  puts "-----+-----+-----"
end

def draw_grid(plays)
  # Clear the screen
  system "clear" or system "cls"

  # Draw the grid
  draw_line
  draw_line([plays[1],plays[2],plays[3]])
  draw_line
  draw_separator
  draw_line
  draw_line([plays[4],plays[5],plays[6]])
  draw_line
  draw_separator
  draw_line
  draw_line([plays[7],plays[8],plays[9]])
  draw_line
end

ROWS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

def winner(plays, mark)
  for row in ROWS
    if plays[row[0]] == mark && plays[row[1]] == mark && plays[row[2]] == mark
      return mark
    end
  end
  return false
end

def empty_positions?(plays)
  plays.select {|k,v| v == " "}.keys
end

def two_in_a_row(hsh, mark)
  if hsh.values.count(mark) == 2
    hsh.select {|k,v| v == " "}.keys.first
  else
    false
  end
end

def position_to_complete_row(plays, mark)
  for row in ROWS
    hsh = plays.select{|k,v| row.include?(k)}
    if pos = two_in_a_row(hsh, mark)
      return pos
      break
    end
  end
  return false
end

def player_picks(plays)
  puts "Choose a position (from 1 to 9) to place a piece:"
  begin
    choice = gets.chomp.to_i
  end until plays[choice] == " "
  return choice
end

def computer_picks(plays)
  if pos = position_to_complete_row(plays, "O")
    choice = pos
  elsif pos = position_to_complete_row(plays, "X")
    choice = pos
  else
    choice = empty_positions?(plays).sample
  end
  return choice
end

def one_player_picks(plays, mark)
  if mark == "X"
    choice = player_picks(plays)
  elsif mark == "O"
    choice = computer_picks(plays)
  end
  plays[choice] = mark
end

# Stores the plays, initially " "
plays = Hash.new
(1..9).each {|i| plays[i] = " "}

draw_grid(plays)

game_ended = false
begin

  for player_mark in ["X","O"]
    one_player_picks(plays,player_mark)
    draw_grid(plays)

    if empty_positions?(plays) == []
      puts "It's a tie."
      game_ended = true
      break
    end

    winner_mark = winner(plays, player_mark)
    if winner_mark == "X"
      puts "Great job! You won."
      game_ended = true
      break
    elsif winner_mark == "O"
      puts "The computer won."
      game_ended = true
      break
    end
  end

end until game_ended == true
