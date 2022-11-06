
  # Creates the board. Each square on the grid is a key value pair
  # The board hash is ordered visually organised in the way that mimics the board layout for ease.
  #Is in a module with a method to make it accessible everywhere.
  module BoardData
    @board = {
          a3: " ", b3: " ", c3: " ",
          a2: " ", b2: " ", c2: " ",
          a1: " ", b1: " ", c1: " "
    }
    def self.board
      @board
    end
  
    # Method to display the board to players.
    def self.display
      puts "
  3 #{@board[:a3]} | #{@board[:b3]} | #{@board[:c3]} 
   ---+---+---
  2 #{@board[:a2]} | #{@board[:b2]} | #{@board[:c2]} 
   ---+---+---
  1 #{@board[:a1]} | #{@board[:b1]} | #{@board[:c1]} 
    A   B   C
  "
    end
  
    # Declares count variable and makes it accessible.
    @count = 0
    def self.count
      @count
    end
  
    def self.count_up
      @count += 1
    end

    # Declares a variable to track who had the last move.
    @last_move = nil
    def self.last_move_x
      @last_move = "X"
    end

    def self.last_move_o
      @last_move = "O"
    end
  
    # Checks all 8 win conditions or a draw after minimum turns needed to win.
    def self.check_win
      # Checks middle square (of the specific win condition) is not empty and compares it to the squares beside it.
      # Top row
      if @board[:b3] != " " && @board[:b3] == @board[:a3] && @board[:b3] == @board[:c3]
        puts "win"
      # Middle row
      elsif @board[:b2] != " " && @board[:b2] == @board[:a2] && @board[:b2] == @board[:c2]
        puts "win"
      # Bottom row
      elsif @board[:b1] != " " && @board[:b1] == @board[:a1] && @board[:b1] == @board[:c1]
        puts "win"
      # Left column
      elsif @board[:a2] != " " && @board[:a2] == @board[:a3] && @board[:a2] == @board[:a1]
      puts "win"
      # Middle column
      elsif @board[:b2] != " " && @board[:b2] == @board[:b3] && @board[:b2] == @board[:b1]
        puts "win"
      # Right column
      elsif @board[:c2] != " " && @board[:c2] == @board[:c3] && @board[:c2] == @board[:c1]
        puts "win"
      # Diagonal \
      elsif @board[:b2] != " " && @board[:b2] == @board[:a3] && @board[:b2] == @board[:c1]
        puts "win"
      # Diagonal /
      elsif @board[:b2] != " " && @board[:b2] == @board[:c3] && @board[:b2] == @board[:a1]
        puts "win"
      # No win, check for draw
      elsif @count == 9
        puts "draw"
      # No win/draw
      else
        # Check who has the next turn.
        if @last_move == "X"
          o_move
        else
          x_move
        end
      end
    end
  
  end
  
  
  
  # Gets input from user, and capitalises.
  def choose
    start = gets.chomp.strip.upcase
    start_game(start)
  end
  
  
  # Takes result of choose method to start game with specified player.
  def start_game(start)
    if start == "X"
      puts "#{start} will go first. Let's play!\n\n"
      puts BoardData.display
      x_move
    # Allows for the event that a player enters 0 instead of O and converts it to O for them.
    elsif start == "O" || start == "0"
      start = "O"
      puts "#{start} will go first. Let's play!\n\n"
      puts BoardData.display
      o_move
    else
      print "Invalid input.\n\nPlease enter either #{"X"} or #{"O"}:\n"
      choose
    end
  end
  
  
  # X move
  def x_move
    puts "It is X's move. Choose a coordinate on the board.\n"
    coord_in = gets.chomp
    # Cleans input with gsub, turns into string and adds ':' to make it a symbol.
    coord = :"#{coord_in.gsub(/\s+/, "_").downcase}"
    # key? method checks if input is valid (if key exists).
    if BoardData.board.key?(coord) == true
      # Checks if square is already filled.
      if BoardData.board[coord] == " "
        # Updates key value and displays updated grid.
        BoardData.board[coord] = "X"
        BoardData.display
        BoardData.count_up
        if BoardData.count >= 5
          BoardData.last_move_x
          BoardData.check_win
        else
          puts"\n"
          o_move
        end
      else
        puts "Square already filled, pick an empty one.\n"
        x_move
      end
    else
      puts "Invalid input. Pick an empty coordinate on the grid.\n"
      x_move
    end
  end
  
  
  # O move
  def o_move
    puts "It is O's move. Choose a coordinate on the board.\n"
    coord_in = gets.chomp
    # Cleans input with gsub, turns into string and adds ':' to make it a symbol.
    coord = :"#{coord_in.gsub(/\s+/, "_").downcase}"
    # key? method checks if input is valid (if key exists).
    if BoardData.board.key?(coord) == true
      # Checks if square is already filled.
      if BoardData.board[coord] == " "
        # Updates key value and displays updated grid.
        BoardData.board[coord] = "O"
        BoardData.display
        BoardData.count_up
        if BoardData.count >= 5
          BoardData.last_move_o
          BoardData.check_win
        else
          puts"\n"
          x_move
        end
      else
        puts "Square already filled, pick an empty one.\n"
        o_move
      end
    else
      puts "Invalid input. Pick an empty coordinate on the grid.\n"
      o_move
    end
  end
  
     
  # Welcomes the player, asks who will play first.
  puts "Welcome to Naughts and Crosses!\nThis is a two player game.\n\nWho will go first? Enter X or O:\n"
  # Calls method to allow input.
  choose