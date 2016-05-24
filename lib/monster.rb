# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prize.rb'
require_relative 'bad_consequence.rb'

module NapakalakiGame
  class Monster
    def initialize(name,level,bads,goods,lC)
      @name = name
      @level = level
      @badconsequence = bads
      @prize = goods
      @levelChangeAgainstCultistPlayer = lC
    end
    private_class_method :new
    
    def self.Monster(name,level,bads,goods)
      new(name,level,bads,goods,0)
    end
    def self.MonsterC(name,level,bads,goods,lC)
      new(name,level,bads,goods,lC)
    end
    def getCombatLevelAgainstCultistPlayer()
      return getCombatLevel + @levelChangeAgainstCultistPlayer
    end
    def getName()
      return @name
    end
    def getCombatLevel()
      return @level
    end
    def getBadConsequence()
      return @badconsequence
    end
    def getLevelsGained()
      return @prize.getLevels()
    end
    def getTreasuresGained()
      return @prize.getTreasures()
    end
    def to_s()
      return "Nombre:"+@name.to_s()+" Nivel:"+@level.to_s()+"\n\tMal royo: "+@badconsequence.to_s()+"\n\tBuen royo: "+@prize.to_s()
    end
  end
end
