# Display a welcome message
# Display the tic tac toe game board
#       |     |     
#       |     |
#       |     |
# -------------------
#       |     |
#       |     |
#       |     |
# -------------------
#       |     |     
#       |     |
#       |     |
# create an array of winning moves
# assign each square a number (1 - 9)
# ask the user to select a number
# Place an X in the selected number(square)
# computer places an O in a blocking square
# If a winning move is detected, display winning message for user or computer

require 'pry'

def initialize_board
  b = {}
  (1..9).each { |square| b[square] = ' '}
  b
end

def display_game_board(b)
  system 'clear'
  puts "                       "
  puts "       |       |       "
  puts "   #{b[1]}   |   #{b[2]}   |   #{b[3]} "
  puts "       |       |       "
  puts "-------|-------|-------"
  puts "       |       |       "
  puts "   #{b[4]}   |   #{b[5]}   |   #{b[6]} "
  puts "       |       |       "
  puts "-------|-------|-------"
  puts "       |       |       "
  puts "   #{b[7]}   |   #{b[8]}   |   #{b[9]} " 
  puts "       |       |       " 
  puts "                       "
end

def empty_square(b)
  b.select { |k, v| v == ' ' }.keys
end

def player_selects_square(board)
  begin
    puts "Please select a square on the board by selecting a number from 1 to 9:"
    square = gets.chomp.to_i
  end while !(1..9).include?(square)
  board[square] = 'X'
end

def computer_selects_square(board)
  square = empty_square(board).sample
  board[square] = 'O'
end

def display_winning_message(board)
  winning_moves = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  winning_moves.each do |line|
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

def declare_winner(winner)
  puts "#{winner} has won!!!"
end

def board_is_filled?(board)
  empty_square(board) == []
end

board = initialize_board
display_game_board(board)

begin
  puts "Hello, welcome to my Tic Tac Toe game!"
  player_selects_square(board)
  display_game_board(board)
  computer_selects_square(board)
  display_game_board(board)
  winner = display_winning_message(board)
end until winner || board_is_filled?(board)

if winner
  declare_winner(winner)
else
  puts "It's a tie!"
end

