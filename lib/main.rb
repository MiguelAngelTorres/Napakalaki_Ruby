#encoding: utf-8

require_relative 'napakalaki.rb'
require_relative 'combat_result.rb'

module NapakalakiGame
  class Examen
    def initialize
      
    end
    def main(players)
      game = Napakalaki.instance
      game.initGame(players)
      puts "El jugador "+game.getCurrentPlayer.to_s+"\nva a luchar contra:\n"
      puts game.getCurrentMonster().to_s()+"\n\n\n"
      resbatalla = game.developCombat()
      if(resbatalla == CombatResult::WIN)
        puts "Enhorabuena chavahh, has ganado al mostro"
      else
        puts "Vaya, has caido como pechuguita"
      end
    end
  end

prueba = Examen.new()
prueba.main(["paco","juan"])

end