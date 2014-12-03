WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

def initialize_board
  board = {}
  (1..9).each { |position| board[position] = ' ' }
  board
end

def empty_positions(board)
  board.keys.select { |position| board[position] == ' ' }
end

def all_filled?(board)
  empty_positions(board) == []
end

def two_in_a_row(hsh, mrkr)
  if hsh.values.count(mrkr) == 2
    hsh.select { |k, v| v == ' ' }.keys.first
  else
    false
  end
end

def determine_the_winner(board)
  winning_lines = WINNING_LINES
  winning_lines.each do |line|
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

def declare_winner(winner)
  puts "#{winner} has won!!!"
end

def draw_board(board)
  system 'clear'
  puts ' '
  puts "       |       |       "
  puts "   #{board[1]}   |   #{board[2]}   |   #{board[3]}   "
  puts "       |       |       "
  puts "-------+-------+-------"
  puts "       |       |       "
  puts "   #{board[4]}   |   #{board[5]}   |   #{board[6]}   "
  puts "       |       |       "
  puts "-------+-------+-------"
  puts "       |       |       "
  puts "   #{board[7]}   |   #{board[8]}   |   #{board[9]}   "
  puts "       |       |       "
  puts ' '
end

def player_picks_a_square(board)
  begin
    puts "Pick a number from 1 to 9 to select a square:"
    square = gets.chomp.to_i
  end until empty_positions(board).include?(square)
  board[square] = 'X'
end

def computer_picks_a_square(line, board)
  # square = empty_positions(board).sample
  defend_this_square = nil
  attacked = false

  WINNING_LINES.each do |line|
    defend_this_square = two_in_a_row( {line[0] => board[line[0]], line[1] => board[line[1]], line[2] => board[line[2]]}, "O")
    if defend_this_square
      board[defend_this_square] = 'O'
      attacked = true
      break
    end
  end

  if attacked == false
    WINNING_LINES.each do |line|
      defend_this_square = two_in_a_row( {line[0] => board[line[0]], line[1] => board[line[1]], line[2] => board[line[2]]}, "X")
      if defend_this_square
        board[defend_this_square] = "O"
        break
      end
    end
  end
  board[empty_positions(board).sample] = "O" unless defend_this_square
end

loop do
  board = initialize_board
  draw_board(board)

  begin
    player_picks_a_square(board)
    draw_board(board)
    computer_picks_a_square(WINNING_LINES, board)
    draw_board(board)
    winner = determine_the_winner(board)
  end until winner || all_filled?(board)

  if winner
    declare_winner(winner)
  else
    puts "It's a tie!!!"
  end

  puts "Would you like to play again? (y/n)"
  break if gets.chomp == 'n'

end
