# Draw the board
# assign values to each square using a hash

def initialize_board
  b = {}
  (1..9).each { |square| b[square] = ' ' }
  b
end

def draw_board(b)
  system 'clear'
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
end

def empty_square(b)
  b.select { |k, v| v = ' ' }.keys
end

def user_picks_a_square(board)
  begin 
    puts "Please enter a number between 1 and 9."
    square = gets.chomp.to_i
  end while !(1..9).include?(square)
  board[square] = 'X'
end

def computer_picks_a_square(board)
  square = empty_square(board).sample
  board[square] = 'O'
end

def determine_the_winner(board)
  winning_moves = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  winning_moves.each do |line|
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

def display_winning_message(winner)
  puts "#{winner} has won!!!"
end

def is_board_filled?(board)
  empty_square(board) == []
end

loop do
  board = initialize_board
  draw_board(board)

  puts "Welcome to my tic tac toe game!!!"

  begin
    puts "Lets Play!!!"
    user_picks_a_square(board)
    draw_board(board)
    computer_picks_a_square(board)
    draw_board(board)
    winner = determine_the_winner(board)
  end until winner || is_board_filled?(board)

  if winner
    display_winning_message(winner)
  else
    puts "It's a tie!"
  end

  puts "Would you like to play again? (y/n)"
  break if gets.chomp == 'n'

end