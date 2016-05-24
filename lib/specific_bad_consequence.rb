require_relative 'bad_consequence.rb'
module NapakalakiGame
  class SpecificBadConsequence < BadConsequence
    def initialize(text, levels, specVisible, specHidden)
      super(text,levels)
      @specificHiddenTreasures = specHidden
      @specificVisibleTreasures = specVisible
    end
    def isEmpty()
       if(@specificHiddenTreasures.length == 0 && @specificVisibleTreasures.length == 0)
         return true
       end
    return false
    end
    def getSpecificHiddenTreasures()
      return @specificHiddenTreasures
    end
    def getSpecificVisibleTreasures()
      return @specificVisibleTreasures
    end
    def substractVisibleTreasures(t)
      n = @specificVisibleTreasures.find_index(t.getType())
      if(n != nil)
        @specificVisibleTreasures.delete_at(n)
      end
    end
    def substractHiddenTreasures(t)
      n = @specificHiddenTreasures.find_index(t.getType())
      if(n != nil)
        @specificHiddenTreasures.delete_at(n)
      end
    end
    def adjustToFitTreasuresLists(visible,hidden)
      aux = Array.new(@specificHiddenTreasures)
      visible = visible.map { |e| e.getType() }
      hidden = hidden.map { |e| e.getType() }
      resv = Array.new()
      resh = Array.new()
      aux.each do |taux|
        hidden.each do |tfix|
          if(taux == tfix)
            resh << taux
            aux.delete_at(aux.find_index(taux))
          end
        end
      end
      aux = Array.new(@specificVisibleTreasures)
      aux.each do |taux|
        visible.each do |tfix|
          if(taux == tfix)
            resv << taux
            aux.delete_at(aux.find_index(taux))
          end
        end
      end
      if(resv.length != 0 || resh.length != 0)
        res = SpecificBadConsequence.new(@text+"(MODIFICADO)",0,resv,resh)
        return res
      else
        return nil
      end
    end
    def to_s()
      return @text.to_s() +"\n\t\tNiveles:"+@levels.to_s()+"\n\t\tspecHidden:"+@specificHiddenTreasures.to_s()+"\n\t\tspecVisible:"+@specificVisibleTreasures.to_s()
    end
  end
end
