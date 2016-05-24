# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  class CultistPlayer < Player
    @@totalCultistPlayers = 0
    def initialize(p,c)
      Playercopia(p)
      @cultist = c 
    end
    
    def Playercopia(p)
      super
    end
    def self.getTotalCultistPlayers()
      return @@totalCultistPlayers
    end
    def getCombatLevel()
      aux = super
      return aux + (aux/2).floor + @cultist.getGainedLevels 
    end
    def getOponentLevel(m)
      m.getCombatLevelAgainstCultistPlayer
    end
    def shouldConvert()
      return false
    end
    #EXAMEN
    def applyBadConsequence(m)
      bads = m.getBadConsequence
      if(bads.instance_of? DeathBadConsequence)
        nLevels = bads.getLevels
        decrementLevels(nLevels)
        pendingBad = bads.adjustToFitTreasuresLists(@visibleTreasures, @hiddenTreasures)
        setPendingBadConsequence(pendingBad)
      end
    end
    #FIN EXAMEN
    def to_s()
      if(@pendingBadConsequence == nil)
        mensaje = "[]"
      else
        mensaje = @pendingBadConsequence.to_s()
      end
      visible = "["
      @visibleTreasures.each do |treas|
        visible = visible + "[" + treas.to_s() + "]," 
      end
      visible = visible + "]"
      hidden = "["
      @hiddenTreasures.each do |treas|
        hidden = hidden + "[" + treas.to_s() + "]," 
      end
      hidden = hidden + "]"
      return @name.to_s+" de nivel "+@level.to_s()+" que esta muerto: "+@dead.to_s()+"  Cultist: "+@cultist.to_s()+"\n\t"+"VisibleTreasures: "+ visible +"\n\tHiddenTreasures: "+ hidden +"\n\nPendingBadConsequnce: "+mensaje
    end
  end
end
