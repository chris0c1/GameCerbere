require "./player.cr"
require "./board.cr"

class Cerbere::Game
	getter players : Array(Player)
	getter active = false
	property board : Board = Board.new(0, [] of Player)
    	property difficulty : Int32 = 3
   	property number_players : Int32 = 3

	def initialize()
		@players = [] of Player
	end

	def <<(player : Player)
		i = Colour::Cyan
		until check_colour(i)
			i = i+1
		end
		player.colour=i
		@players << player
	end

	def send_all(response : Response)
		@players.each do |player|
			player.send response
		end
	end

	def check_players()
		if @players.size==@number_players
			if @players.all? &.ready == true
				@active = true
			end
		end
		@active
	end

	def check_colour(colour : Cerbere::Colour)
		@players.all? { |player| player.colour != colour}
	end

    	def start(@difficulty, @players)
        	@number_players = players.size
        	@board = Board.new(@difficulty, @players)
    	end
end
