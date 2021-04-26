require "./hand.cr"

require "json"
require "kemal"
require "db"
require "mysql"

enum Cerbere::Colour
	def to_json(o)
		o.scalar self.to_s
	end
	Cyan
	Orange 
	Green
	Pink
	Blue
	White
	Red
end

enum TypeJoueur
	AVENTURIER # Joueur dans le camp Aventurier
	CERBERE # Joueur dans le camp Cerbère
	MORT # Joueur éliminé
end

class Cerbere::Player
	include JSON::Serializable

	property ready = false
	property name : String = ""
	property colour : Colour | Nil = Cerbere::Colour::Cyan
	@[JSON::Field(ignore: true)]
	getter socket : HTTP::WebSocket | Nil
	
	property type : TypeJoueur = TypeJoueur::AVENTURIER
	property position : Int32 = 1

	property lobby_id : Int32 = 0
	#@[JSON::Field(ignore: true)]
	property hand : Hand = Hand.new# Classe temporaire representant les utilisateurs provenant du lobby
	property type : TypeJoueur = TypeJoueur::AVENTURIER
	property owner = false
	property password : String

	def send(response : Response)
		unless (@socket.nil?)
			@socket.not_nil!.send(response.to_json)
		end
	end

	def initialize(@name, @socket)
	end

	def initialize(@lobby_id)
	end

	def authentification(game)
		DB.open "mysql://root@localhost/database" do |db|
			db.query "SELECT tab_joueur FROM tab_joueur WHERE tab_joueur.pseudo_joueur = ?", @name do |result|
				if result.column_count == 1
					#TODO : vérifier que @password == mdp stocké dans la BDD, sinon, refuser la connexion
				elsif result.column_count == 0
					#TODO : On a pas le player, donc il faut créer un nouveau joueur avec @name et @password
				else
					#TODO : On a plus qu'une colonne, donc on a une duplication dans la BDD, il faut lancer une alerte
				end
			end
		end

		if game.players.size == 0
			@owner = true
		end

		game.send_all Response::NewPlayer.new self
		game << self

		send(Response::Welcome.new game.players, game.players.size-1)

	end
end
