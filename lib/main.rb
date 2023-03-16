require_relative "gameboard.rb"
require_relative "piece.rb"
require_relative "game.rb"
require_relative "Pieces/knight.rb"
require_relative "Pieces/pawn.rb"
require_relative "Pieces/rook.rb"
require_relative "Pieces/queen.rb"
require_relative "Pieces/bishop.rb"
require_relative "Pieces/king.rb"

# my_knight = Knight.new([8, 8], "white")
# #print "Knight Position is: #{my_knight.get_position()}"
# #print "\nFinal Moves: #{my_knight.generate_moves.map { |move| move.map { |num| num + 1 } }}"
# #print "\nMove To #{my_knight.generate_move_to([7, 7])}" # remember that the array is indexed starting from 0
# print "COMPUTER POS IS: #{my_knight.get_position}\n"
# print "COMPUTER POS IS: #{my_knight.get_human_pos}\n"

# my_knight.print_board
# #use a queue to store all possible moves like were doing a BFS

game = Game.new()

game.play()

# method that shows all possible moves of a certain piece with ▲ and https://www.w3.org/TR/xml-entity-names/025.html
# could make pos a class that has a value of is human of is computer pos.
