require_relative "gameboard.rb"
require_relative "piece.rb"
require_relative "colorize.rb"

class Game
  Starting_pos = {
    "knight" => [[2, 1], [7, 1]],
    "rook" => [[1, 1], [8, 1]],
    "bishop" => [[3, 1], [6, 1]],
  }
  Starting_pos.freeze

  def initialize()
    #Setup White First
    @board = Gameboard.new(8)
    @pieces_taken = { "white" => [], "black" => [] }

    Starting_pos.each do |piece_name, piece_positions|
      piece_positions.each do |piece_pos|
        piece_class = Object.const_get(piece_name.capitalize)
        piece = piece_class.new(piece_pos, "white")
        @board.addPiece(piece, piece_pos)
        puts "added piece #{piece.class.name}"
      end
    end

    Starting_pos.each do |piece_name, piece_positions|
      piece_positions.each do |piece_pos|
        piece_pos[1] = 9 - piece_pos[1]
        piece_class = Object.const_get(piece_name.capitalize)
        piece = piece_class.new(piece_pos, "black")
        @board.addPiece(piece, piece_pos)
      end
    end

    print_game()
  end

  def move(piece, new_pos, color)
    new_pos = @board.get_computer_pos(new_pos)
    puts "Right here #{piece.class.name}" # failure here.
    return false if !piece.check_move(new_pos, @board.board)
    print "new_pos is #{new_pos}"
    taken_Piece = @board.get_piece_computer_pos(new_pos)
    puts "TAKEN PIECE?"
    if taken_Piece
      puts "taken_Piece.color is #{taken_Piece.color} and color is #{color}"
      if taken_Piece.color.downcase == color.downcase
        return false
      end
      @pieces_taken[color.downcase] << taken_Piece.class.name
    end
    @board.movePiece(piece, new_pos)
  end

  def checkmate()
    return false
  end

  def play #  and make sure move is possible and that nothing blocks the piece.
    #moves = ["[2,1] [3,3]", "[2,8] [1,6]", "[3,3] [4,5]", "7,8 6,6", "[4,5][2,4]", "6,6 4,5", "2,4 1,6", "1,6 2,4", "4,5 5,3", "1,6 2,3"]
    moves = ["2,1 4,2", "2,8 1,6", "4,2 6,3", "7,8 8,6", "6,3 7,1", "8,1 7,2", "8,1 8,6", "3,8 8,3", "6,1 8,3", "6,8 4,6", "8,6 5,6", "1,8 7,8", "8,3 8,4", "8,3 6,5"]
    i = -1
    color = "Black"
    while !checkmate() && (moves.length - 1) > i
      color = color == "White" ? "Black" : "White"
      puts "#{color}'s Turn".bold.green.bg_blue
      puts "Input: <location of piece to move> [x,y] <location to go>[x,y]"
      move = []
      repeat = false
      while (move.length < 2 || repeat) && (moves.length - 1) > i # skipping over the i's.
        # @board.print_pieces {|i, j, piece| puts "#{i}, #{j} class is #{piece.class.name}"}
        move = []
        puts "i is #{i + 1}"

        input = moves[i += 1] #gets.chomp

        print "\n input is #{input}"

        input.gsub(/\d{1}[,\s]\d{1}/) { |match| move << Array.new(match.split(",").map(&:to_i)) }
        next if move.length < 2
        next if move.any? { |sub_move| sub_move.length < 2 }
        print "\n move 0 is #{move[0]}"
        piece = @board.get_piece(move[0])
        puts "Piece is #{piece.class.name}"
        next if !piece.is_a?(Piece)
        puts "85 is #{piece.class.name}"

        next if piece.color.downcase != color.downcase

        puts "87 is #{piece.class.name}"

        if !move(piece, move[1], color) # check if move is possible, check for pieces taken(print out pieces taken by each side each round)
          repeat = true
          next
        end
        puts "\nPiece is Valid"
        #print "\nPIECE POSITION IS #{piece.pos}\n"
        print_game()
        break
        #@@board.print_pieces {|i, j, column| puts "#{i}, #{j} is #{column.pos if column}"}
      end
    end
  end

  def print_game()
    #print "\r" + ("\e[A\e[K"*24) # use to remove the last chess board.

    @board.print_board
    print "-----------Pieces Taken----------- \n"
    @pieces_taken.each do |color, value|
      print "#{color.capitalize}: "
      value.each { |piece_name| print "#{Gameboard.get_chess_piece_icon(piece_name, color.downcase == "white" ? "black" : "white")} " }
    end
    print "\n\n"
  end
end
