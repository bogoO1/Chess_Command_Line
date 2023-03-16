require_relative "../piece.rb"

class Queen < Piece # make a method move_to that checks if its possible to make a certain move, and then calls super.
  #set up the knight and allow it to generate all possible moves and be on the board.
  #create a method that generates the shorted moves from one location to another

  def check_move(new_pos, board)
    return check_rook_move(new_pos, board) || check_bishop_move(new_pos, board) ? true : false
    # return generate_moves().find {|move| move == new_pos}
  end

  def check_rook_move(new_pos, board)
    return false unless (new_pos[0] == pos[0]) ^ (new_pos[1] == pos[1])
    curr_pos = @pos.clone

    stepDirectionX = (new_pos[0] - pos[0]) == 0 ? 0 : (new_pos[0] - pos[0]) / (new_pos[0] - pos[0]).abs
    stepDirectionY = (new_pos[1] - pos[1]) == 0 ? 0 : (new_pos[1] - pos[1]) / (new_pos[1] - pos[1]).abs
    path_length = [(new_pos[1] - pos[1]).abs, (new_pos[0] - pos[0]).abs].max

    (1...path_length).each do |i|
      print "\n New Check is #{[pos[0] + (i * stepDirectionX), pos[1] + (i * stepDirectionY)]} \n"
      return false unless board.dig(pos[0] + (i * stepDirectionX), pos[1] + (i * stepDirectionY)).nil?
    end
    return true
  end

  def check_bishop_move(new_pos, board)
    return false unless (new_pos[0] - pos[0]).abs == (new_pos[1] - pos[1]).abs
    # check for piece blocking.
    stepDirectionX = (new_pos[0] - pos[0]) == 0 ? 0 : (new_pos[0] - pos[0]) / (new_pos[0] - pos[0]).abs
    stepDirectionY = (new_pos[1] - pos[1]) == 0 ? 0 : (new_pos[1] - pos[1]) / (new_pos[1] - pos[1]).abs
    path_length = [(new_pos[1] - pos[1]).abs, (new_pos[0] - pos[0]).abs].max

    (1...path_length).each do |i|
      print "\n New Check is #{[pos[0] + (i * stepDirectionX), pos[1] + (i * stepDirectionY)]} \n"
      return false unless board.dig(pos[0] + (i * stepDirectionX), pos[1] + (i * stepDirectionY)).nil?
    end
    return true
  end
end
