require_relative "../piece.rb"

class King < Piece # make a method move_to that checks if its possible to make a certain move, and then calls super.
  #set up the knight and allow it to generate all possible moves and be on the board.
  #create a method that generates the shorted moves from one location to another
  @@move_pattern = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]]

  def generate_moves(from = @pos, visited = nil)
    moves = @@move_pattern.map { |pattern| [pattern[0] + from[0], pattern[1] + from[1]] }
    # print "Moves Before are: #{moves.map {|move| move.map{|num| num + 1}}}\n"
    moves.delete_if do |move|
      #print move
      move[0] > 7 || move[1] > 7 || move[0] < 0 || move[1] < 0 ? true : false # ternary operator
    end
    moves.delete_if { |move| visited.find { |visit| visit == move } } if visited
    #print "Moves AFTER are: #{moves.map {|move| move.map{|num| num + 1}}}\n"

    return moves
  end

  def generate_move_to(move_pos) # each value in the queue must be a queue to remember the moves we made to get there.
    queue = [[pos]]
    squares_visisted = []
    while queue.length > 0
      currMove = queue.shift

      print "\nsquares_visisted is: #{squares_visisted}"
      print "\nsquares_visisted.find is: #{squares_visisted.find { |move| move == currMove[-1] }}"
      next if squares_visisted.find { |move| move == currMove[-1] }
      print "\ncurrMove is: #{currMove}"

      squares_visisted << currMove[-1]

      # print "\nmove_pos is: #{move_pos}"

      return currMove if currMove[-1] == move_pos
      print "\nGENERATED MOVES IS: #{generate_moves(currMove[-1], squares_visisted)}\n" # ADDED IN THE [-1]  to currmove
      queue.push(*generate_moves(currMove[-1], squares_visisted).map { |move| currMove + [move] })
    end
    return currMove
  end

  def check_move(new_pos, board)
    return true if generate_moves().any? { |move| move == new_pos }
    false
    # return generate_moves().find {|move| move == new_pos}
  end
end
