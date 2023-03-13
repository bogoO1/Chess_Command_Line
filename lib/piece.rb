require_relative "gameboard"

class Piece
  attr_accessor :pos, :name, :color


  def initialize(pos, color)
    @pos = pos
    @color = color
  end

  # def move(newPos)
  #   @@gameboard.movePiece(self, newPos)
  # end

  def get_position()
    return @pos
  end

  # def get_computer_pos
  #   return @@gameboard.get_computer_pos @pos
  # end

  # def get_human_pos
  #   return @@gameboard.get_human_pos @pos
  # end

  # def print_board
  #   @@gameboard.print_board
  # end
end
