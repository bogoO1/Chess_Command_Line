require_relative "gameboard.rb"
require_relative "piece.rb"

class Game
  Starting_pos = {
    "knight" => [[2, 1], [7, 1]],
  }
  Starting_pos.freeze
  @@board = Gameboard.new(8)

  def initialize()
    #Setup White First
    Starting_pos.each do |piece_name, piece_positions|
      piece_positions.each do |piece_pos|
        piece_class = Object.const_get(piece_name.capitalize)
        piece = piece_class.new(piece_pos, "white")
        print "\npiece_pos.object_id #{piece_pos.object_id}"
        @@board.addPiece(piece, piece_pos)
      end
    end

    Starting_pos.each do |piece_name, piece_positions|
      piece_positions.each do |piece_pos|
        piece_pos[1] = 9 - piece_pos[1]
        piece_class = Object.const_get(piece_name.capitalize)
        piece = piece_class.new(piece_pos, "black")
        print "\npiece_pos.object_id #{piece_pos.object_id}"
        @@board.addPiece(piece, piece_pos)
      end
    end

    @@board.print_board
    #@@board.print_pieces
  end

  def move(piece, new_pos)
    new_pos = @@board.get_computer_pos(new_pos)
    return false if !piece.check_move(new_pos)
    @@board.movePiece(piece, new_pos)
  end

  def checkmate()
    return false
  end

  def play #  and make sure move is possible and that nothing blocks the piece. REMOVE pieces that are moved onto.
    moves = ["[2,1] [3,3]", "[2,8] [1,6]", "[3,3] [4,5]"]
    i = -1
    color = "Black"
    while !checkmate() and moves.length - 1 > i
      color = color == "White" ? "Black" : "White"
      puts "#{color}'s Turn"
      puts "Input: <location of piece to move> [x,y] <location to go>[x,y]"
      move = []
      repeat = false
      while move.length < 2 or repeat
        input = moves[i += 1] #gets.chomp
        input.gsub(/\d{1}[,\s]\d{1}/) { |match| move << Array.new(match.split(",").map(&:to_i)) }
        #print "\nMOVE IS: #{move}\n"
        next if move.length < 2
        next if move.any? { |sub_move| sub_move.length < 2 }

        piece = @@board.get_piece(move[0])
        next if !piece.is_a?(Piece)
        next if piece.color.downcase != color.downcase
        if !move(piece, move[1]) # check if move is possible, check for pieces taken(print out pieces taken by each side each round)
          repeat = true
          next
        end
        puts "\nPiece is Valid"
        #print "\nPIECE POSITION IS #{piece.pos}\n"
        @@board.print_board
        #@@board.print_pieces {|i, j, column| puts "#{i}, #{j} is #{column.pos if column}"}
      end
    end
  end
end