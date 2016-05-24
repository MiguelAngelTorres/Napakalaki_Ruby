require_relative 'bad_consequence.rb'

module NapakalakiGame
  class NumericBadConsequence < BadConsequence
    def initialize(text,levels,nVisible,nHidden)
      super(text,levels)
      @nHiddenTreasures = nHidden
      @nVisibleTreasures = nVisible
    end
    def isEmpty()
       if(@nVisibleTreasures == 0 && @nHiddenTreasures == 0)
         return true
       end
    return false
    end
    def getNVisibleTreasures()
      return @nVisibleTreasures
    end
    def getNHiddenTreasures()
      return @nHiddenTreasures
    end
    def substractVisibleTreasures(t)
      @nVisibleTreasures -= 1
    end
    def substractHiddenTreasures(t)
      @nHiddenTreasures -= 1
    end
    def adjustToFitTreasuresLists(visible,hidden)
      if(@nVisibleTreasures <= visible.length)
        vres = @nVisibleTreasures
      else
        vres = visible.length
      end
      if(@nHiddenTreasures <= hidden.length)
        hres = @nHiddenTreasures
      else
        hres = hidden.length
      end
      res = NumericBadConsequence.new(@text+"(MODIFICADO)", 0, vres, hres)
      return res
    end
    def to_s()
      return @text.to_s() +"\n\t\tNiveles:"+@levels.to_s()+"\n\t\tnHidden:"+@nHiddenTreasures.to_s()+"\n\t\tnVisible:"+@nVisibleTreasures.to_s()
    end
  end
end
