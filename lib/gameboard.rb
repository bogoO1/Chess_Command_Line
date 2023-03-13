
class Gameboard
  #set up the board and allow it to have pieces on it.
  attr_accessor :board # make the piece have their index be their position on the board

@@pieces_emojis = {
  "knight" => {"black" => "♘", "white" => "♞"}
}

  def initialize(size)
    @board = Array.new(size) { Array.new(size) }
  end

  def get_computer_pos(pos)
    pos[0]-=1
    pos[1]-=1

    pos[1] = 7 - pos[1]

    pos[0], pos[1] = pos[1], pos[0]

    return pos
  end

  def get_human_pos(pos)

    pos[0], pos[1] = pos[1], pos[0]

    pos[1] = 7 - pos[1]

    pos[0]+=1
    pos[1]+=1
    return pos
  end

  def get_piece(pos)
    pos = pos.clone
    pos = get_computer_pos(pos)
    return @board.dig(pos[0], pos[1])
  end

  def addPiece(piece, pos)
    pos = pos.clone
    pos = get_computer_pos(pos)
    @board[pos[0]][pos[1]] = piece
    piece.pos = pos
  end

  def movePiece(piece, moveTo)
    #moveTo = get_computer_pos(moveTo)
    piece_pos = piece.pos
    @board[piece_pos[0]][piece_pos[1]] = nil
    @board[moveTo[0]][moveTo[1]] = piece
    piece.pos = moveTo
  end

  def print_board() # prints the board in all its glory and all pieces on it.
    num_row = 8
    print "\n ┏━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┓\n"
    board.map do |row|
      print "#{num_row}"
      row.map do |column|
        if column.is_a?(Piece)
          print "┃ #{@@pieces_emojis[column.class.name.downcase][column.color.downcase]} "
        else
          print "┃   "
        end
      end
      num_row -= 1
      print "┃\n ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫\n" if num_row > 0
      print "┃\n" if num_row <= 0
    end

    print " ┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛\n"
    print "   1   2   3   4   5   6   7   8\n"

    #"┗"
  end

  def print_pieces(&block) # prints the board in all its glory and all pieces on it.
    block = -> (i, j, column) {puts "#{i}, #{j} is #{column.pos if column}"} unless block_given?
    board.each_with_index do |row, i|
      row.each_with_index do |column, j|
        block.call(i,j,column)
        
        #puts "#{i}, #{j} is #{column}"
      end
    end
  end
end