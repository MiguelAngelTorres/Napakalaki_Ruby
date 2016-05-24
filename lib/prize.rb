# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame
  class Prize
    def initialize(treasure,level)
      @treasure = treasure
      @levels = level
    end
    def getTreasures()
      return @treasure
    end
    def getLevels()
      return @levels
    end
    def to_s()
      return "Se te recompensa con "+@levels.to_s()+" nivel(es) y "+@treasure.to_s()+" tesoro(s)."
    end
  end
end