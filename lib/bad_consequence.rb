require_relative 'player.rb'

module NapakalakiGame
  class BadConsequence

    @@MAXTREASURES = 10
    def self.maxtreasures
      return @@MAXTREASURES
    end
    
    def isEmpty()
       raise NotImplementedError.new 
    end
    def getLevels()
      return @levels
    end
    def substractVisibleTreasures(t)
      raise NotImplementedError.new 
    end
    def substractHiddenTreasures(t)
      raise NotImplementedError.new 
    end 
    def initialize(aText,someLevels)
      @text = aText
      @levels = someLevels
    end

    def adjustToFitTreasuresLists(visible,hidden)
      raise NotImplementedError.new
    end
  end
end