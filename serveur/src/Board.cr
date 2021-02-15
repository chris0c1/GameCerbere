require "./Node.cr"
require "./Player.cr"
require "./BOARD_0.cr"

class Board
    getter nodes : Array(Node)
    property barques : Array(Int32) = [1, 2, 3].shuffle
    property rageCerbere : Int32
    property vitesseCerbere : Int32
    property positionCerbere : Int32 = 0
    property players : Array(Player) = [] of Player
    property piocheSurvie : DeckSurvie = DeckSurvie.new
    property piocheTrahison : DeckTrahison  = DeckTrahison.new

    def initialize(difficulty : Int32, users : Array(User))

        # Choix du plateau
        # Seulement difficulte 0 disponible pour l'instant
        case difficulty
        when 0
            @nodes = BOARD_0
        when 1
            @nodes = BOARD_0
        when 2
            @nodes = BOARD_0
        else
            @nodes = BOARD_0
        end

        # Creation d'un Player pour chaque User
        users.each do |user|
            @players << Player.new(user.userId)
        end

        # Initialisation des variables de jeu
        @rageCerbere = 8 - users.size
        @vitesseCerbere = 3 + difficulty # A redefinir
    end

    def defausser(joueur : Player,num_carte : Int32)
        if(num_carte < 0 || num_carte >= joueur.myHand.myCartesBonus.size())
            raise "Le joueur #{joueur.lobbyId} ne peut pas défausser la carte #{num_carte} !"
        end
        carte : CarteBonus = joueur.myHand.myCartesBonus.delete_at(num_carte)
        if(joueur.typeJoueur == 2) # Cerbère
            piocheTrahison.dis_card(carte.as(CarteTrahison))
        else # Aventurier ou Eliminé (était Aventurier)
            piocheSurvie.dis_card(carte.as(CarteSurvie))
        end
    end

    def demander(qui : Player,quoi : String) : String
        # Demande une entrée supplémentaire à un joueur particulier
        # Pour le moment, on demande via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobbyId.to_s()+": "+quoi
        res : String? = gets
        return res == Nil ? "" : res.to_s
    end

    def deplacer_moi(moi : Player, force : Int32)
        nb_moves = force.abs

        while (nb_moves > 0)
          # Si l'effet de la case n'a pas changé la position du joueur et qu'il n'essaye pas d'avancer ou reculer hors du plateau
          if !faire_action(moi, nodes[moi.position].effect, [nb_moves, force]) && (moi.position > 1 && force < 0 || moi.position < nodes.size - 1 && force > 0)
            moi.position = force > 0 ? moi.position + 1 : moi.position - 1
          end

          if (moi.position <= positionCerbere)
            # appel à une fonction capture pour changer le rôle du joueur et renvoyer Cerbère au dernier checkpoint
            puts "Le joueur #{moi.lobbyId} s'est fait attrapé par Cerbère !"
            return
          end

          nb_moves -= 1
        end

        faire_action(moi, nodes[moi.position].effect, [nb_moves, force]) # appliquer l'effet de la case d'arrivée
    end

    def envoyer(qui : Player,quoi : String)
        # Envoie une information qui n'est destiné qu'à un joueur particulier
        # Pour le moment, on parle via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobbyId.to_s()+": "+quoi
    end

    def action_reveler_barque(moi : Player)
        @barques.pop(2)
        nodes[moi.position].effect.evenement = Evenement::RIEN # L'action ne peut être effectuée qu'une fois, on réinitialise donc l'effet
        puts "La barque à #{barques[0]} place(s) a été révélée !"
    end

    def action_verif_barque()
      nb_assis = 0
      barque = nodes.size - 1 # Position de la barque (dernière case)

      @players.each do |player|
        if(player.position == barque) # On compte le nombre de joueurs sur la dernière case représentant la barque
          nb_assis += 1
        end
      end

      if(nb_assis == barques[0]) # Barque pleine
        puts "Fin de partie, la barque s'en va !"
      else
        puts "Il manque #{barques[0] - nb_assis} personne(s) pour partir !"
      end
    end

    def action_pont(moi : Player, id_pont : Int32, args : Array(Int32)) : Bool
      if (args[0] == 0) || (id_pont == 0 && args[1] < 0 || id_pont == 1 && args[1] > 0)
        return false
      end
      emprunte = true # permet d'indiquer si on a emprunté le pont à la fonction deplacer_moi
      res = demander(moi, "Prendre le pont ? O/N")
      # Si un joueur prend le pont de cordes, il s'écroule et n'est plus utilisable
      if(res == "O")
        nodes[moi.position].effect.evenement = Evenement::RIEN
        moi.position = id_pont == 1 ? moi.position - 4 : moi.position + 4 #On se sert de la force pour déterminer de quel côté du pont on se trouve
        nodes[moi.position].effect.evenement = Evenement::RIEN
      else
        puts "Refus"
        emprunte = false
      end

      return emprunte
    end

    def action_funiculaire(moi : Player, id_funi : Int32, args : Array(Int32)) : Bool
      if (args[0] != args[1].abs) || (id_funi == 0 && args[1] < 0 || id_funi == 1 && args[1] > 0)
        return false
      end
      emprunte = true # permet d'indiquer si on a emprunté le funiculaire à la fonction deplacer_moi
      res = demander(moi, "Prendre le funiculaire ? O/N")

      if(res == "O")
        moi.position = id_funi == 1 ? moi.position - 3 : moi.position + 3 #On se sert de la force pour déterminer de quel côté du funiculaire on se trouve
      else
        puts "Refus"
        emprunte = false
      end

      return emprunte
    end

    def action_portail(moi : Player, id_portail : Int32, args : Array(Int32)) : Bool
      if (args[0] == 0) || (id_portail == 0 && args[1] < 0 || id_portail == 1 && args[1] > 0)
        return false
      end


      stele = id_portail == 1 ? (moi.position - 1) : (moi.position + 2) # Position de la stèle qui active le portail
      actif = false
      emprunte = true # permet d'indiquer si on a emprunté le portail à la fonction deplacer_moi

      players.each do |player|
        if(player.position == stele) # Si un joueur se trouve sur la stèle, le portail est actif
          actif = true
          break
        end
      end

      if(actif)
        res = demander(moi, "Prendre le portail ? O/N")
        if(res != "O")
          puts "Refus"
          emprunte = false
        elsif(id_portail == 1)
          moi.position -= 3
        else
          moi.position += 3
        end
      else
        puts "Portail non disponible !"
        emprunte = false
      end

      return emprunte
    end

    def action_promontoire(moi : Player, args : Array(Int32))
      if args[0] != 0
        return 1
      end
      requete = [] of Int32
      res = demander(moi, "Voir une barque (0) ou échanger 2 barques (1) ?").to_i32
      if !res.in?(0,1)
         raise "Mauvaise réponse promontoire !"
      end
      requete << res
      if requete[0] == 0
        res = demander(moi, "Quelle barque voulez-vous voir ?").to_i32
        if !res.in?(0, 1, 2)
          raise "Cette barque n'existe pas !"
        end
        requete << res
      else
        res = demander(moi, "Donnez une barque à échanger :").to_i32
        if !res.in?(0, 1, 2)
          raise "Cette barque n'existe pas !"
        end
        requete << res
        res = demander(moi, "Donnez l'autre barque à échanger :").to_i32
        if !res.in?(0, 1, 2) || res == requete[1]
          raise "Cette barque n'existe pas ou vous avez donné la même barque que la première !"
        end
        requete << res
      end
      puts requete
    end

    def action_pilotis(moi : Player, args : Array(Int32))
      if args[0] == args[1].abs
        return 1
      end
      players.each do |player|
        if player.position == moi.position && player != moi
          moi.position = args[1] > 0 ? moi.position - 1 : moi.position + 1
          break
        end
      end
    end


    def faire_action(moi : Player, effet : Effet, args : Array(Int32))
        case effet.evenement
        when Evenement::RIEN
            return false
        when Evenement::RECUPERER_CARTE
            # ...
        when Evenement::PIOCHER_MOI
            # ...
        when Evenement::PIOCHER_ALLIE
            # ...
        when Evenement::DEFAUSSER_MOI
            # ...
        when Evenement::DEFAUSSER_SURVIE
            # ...
        when Evenement::DEFAUSSER_PARTAGE
            # ...
        when Evenement::CHANGER_VITESSE
            # ...
        when Evenement::CHANGER_COLERE
            # ...
        when Evenement::DEPLACER_MOI
            # ...
        when Evenement::DEPLACER_AUTRE
            # ...
        when Evenement::DEPLACER_SURVIVANTS
            # ...
        when Evenement::DEPLACER_CERBERE
            # ...
        when Evenement::BARQUE
            # ...
        when Evenement::COUARDISE
            # ...
        when Evenement::SABOTAGE
            # ...
        when Evenement::PROMONTOIRE
            action_promontoire(moi, args)
        when Evenement::FUNICULAIRE
            return action_funiculaire(moi, effet.force, args)
        when Evenement::PILOTIS
            action_pilotis(moi, args)
        when Evenement::PORTAIL
            return action_portail(moi, effet.force, args)
        when Evenement::REVELER_BARQUE
            action_reveler_barque(moi)
        when Evenement::VERIFIER_BARQUE
            action_verif_barque()
        when Evenement::PONT
            return action_pont(moi, effet.force, args)
        end
    end
end
