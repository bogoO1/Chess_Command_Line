require_relative "../piece.rb"

class Pawn < Piece
  def check_move(new_pos, board)
    print "\n NEWPOS: #{new_pos}; OLD POS: #{pos}"
    if color.downcase == "white"
      # when pawn is white on 2nd row
      # white can only move up

      return true if new_pos[0] - pos[0] == -1
      return true if new_pos[0] - pos[0] == -2 && pos[0] == 6
      return true if (new_pos[0] - pos[0] == -1) && (new_pos[1] - pos[1] == 1) && !board[new_pos[0]][new_pos[1]].nil?
      return true if (new_pos[0] - pos[0] == -1) && (new_pos[1] - pos[1] == -1) && !board[new_pos[0]][new_pos[1]].nil?
    else
      # when pawn is black on 7th row
      return true if new_pos[0] - pos[0] == 1
      return true if new_pos[0] - pos[0] == 2 && pos[0] == 1
      return true if (new_pos[0] - pos[0] == 1) && (new_pos[1] - pos[1] == 1) && !board[new_pos[0]][new_pos[1]].nil?
      return true if (new_pos[0] - pos[0] == 1) && (new_pos[1] - pos[1] == -1) && !board[new_pos[0]][new_pos[1]].nil?
    end

    false
  end
end
