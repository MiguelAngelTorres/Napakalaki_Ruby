# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'treasure.rb'
require_relative 'treasure_kind.rb'
require_relative 'combat_result.rb'
require_relative 'dice.rb'
require_relative 'bad_consequence'

module NapakalakiGame
  class Player
    @@MAXLEVEL = 10
    def self.maxlevel
      return @@MAXLEVEL
    end
    def initialize(name)
      @name=name
      @level = 1
      @dead = true
      @hiddenTreasures = Array.new
      @visibleTreasures = Array.new
      @pendingBadConsequence = nil
    end
    attr_reader :dead,:pendingBadConsequence
    
    def Playercopia(p)
      @name=p.getName
      @level = p.getLevels
      @dead = p.dead
      @hiddenTreasures = p.getHiddenTreasures
      @visibleTreasures = p.getVisibleTreasures
      @pendingBadConsequence = p.pendingBadConsequence
    end
    def getOponentLevel(m)
      return m.getCombatLevel
    end
    #EXAMEN
    def shouldConvert()
      dado = Dice.instance
      if(dado.nextNumber % 2 == 0)
        return true
      else
        return false
      end
    end
    #FIN EXAMEN
    def getName()
      return @name
    end
    private
    def bringToLife()
      @dead = false
    end
    def getCombatLevel()
      res = 0
      @visibleTreasures.each { |treas| res+= treas.getBonus }
      res+= getLevels
    end
    def incrementLevels(l)
      @level += l
    end
    def decrementLevels(l)
      @level -= l
      if (@level < 1)
        @level = 1
      end
    end
    def setPendingBadConsequence(b)
      @pendingBadConsequence = b;
    end
    def applyPrize(mons)
      incrementLevels(mons.getLevelsGained)
      nTreasures = mons.getTreasuresGained
      if(nTreasures > 0)
        dealer = CardDealer.instance
        for i in 1..nTreasures
          @hiddenTreasures << dealer.nextTreasure 
        end
      end
    end
    def applyBadConsequence(m)
      bads = m.getBadConsequence
      nLevels = bads.getLevels
      decrementLevels(nLevels)
      pendingBad = bads.adjustToFitTreasuresLists(@visibleTreasures, @hiddenTreasures)
      setPendingBadConsequence(pendingBad)
    end
    def canMakeTreasureVisible(t)
      aux = @visibleTreasures.select { |treas| treas.getType() == t.getType() }
      if(t.getType() == TreasureKind::ONEHAND)
        if((!(@visibleTreasures.select { |treas| treas.getType() == TreasureKind::BOTHHANDS }).empty?))
          return false
        else
          if(aux.length <= 1)
            return true
          else
            return false
          end
        end
      end
      if(t.getType() == TreasureKind::BOTHHANDS)
        if(!(@visibleTreasures.select{ |treas| treas.getType() == TreasureKind::ONEHAND }.empty?))
          return false
        end
      end
      if(aux.length == 1)
        return false
      else 
        return true
      end
    end
    def howManyVisibleTreasurestKind(tKind)
      aux = @visibleTreasures.select{ |treas| treas.getType == tKind }
      return aux.size
    end
    def dieIfNoTreasures()
      if(@hiddenTreasures.size == 0 && @visibleTreasures.size == 0)
        @dead = true
      end
    end
    public
    def isDead()
      return @dead
    end
    def getHiddenTreasures()
      return @hiddenTreasures
    end
    def getVisibleTreasures()
      return @visibleTreasures
    end
    def combat(mons)
      res = 0
      if(getCombatLevel > getOponentLevel(mons))
        @pendingBadConsequence = nil
        applyPrize(mons)
        if(getLevels >= @@MAXLEVEL)
          res = CombatResult::WINGAME
        else
          res = CombatResult::WIN
        end
      else
        applyBadConsequence(mons)
        if(shouldConvert)
          res = CombatResult::LOSEANDCONVERT
        else
          res = CombatResult::LOSE
        end
      end
    return res
    end
    def makeTreasureVisible(t)
      if(canMakeTreasureVisible(t))
        @visibleTreasures << t
        @hiddenTreasures.delete_at(@hiddenTreasures.find_index { |treas| treas == t } )
      end
    end
    def discardVisibleTreasure(t)
      dealer = CardDealer.instance()
      @visibleTreasures.delete_at(@visibleTreasures.find_index { |treas| treas == t } )
      dealer.giveTreasureBack(t)
      if(@pendingBadConsequence!=nil && !(@pendingBadConsequence.isEmpty))
        @pendingBadConsequence.substractVisibleTreasures(t)
      end
      dieIfNoTreasures
    end
    def discardHiddenTreasure(t)
      @hiddenTreasures.delete_at(@hiddenTreasures.find_index { |treas| treas == t } )
      dealer = CardDealer.instance()
      dealer.giveTreasureBack(t)
      if(@pendingBadConsequence!=nil && !(@pendingBadConsequence.isEmpty))
        @pendingBadConsequence.substractHiddenTreasures(t)
      end
      dieIfNoTreasures
    end
    def validState()
      valid = false
      if(@pendingBadConsequence == nil && @hiddenTreasures.length <= 4)
        valid = true
      else 
        if(@pendingBadConsequence.isEmpty && @hiddenTreasures.length <= 4)
          valid = true
        end
      end
    return valid
    end
    def initTreasures()
      dealer = CardDealer.instance
      dado = Dice.instance
      bringToLife
      @hiddenTreasures << dealer.nextTreasure
      number = dado.nextNumber
      if(number > 1)
        @hiddenTreasures << dealer.nextTreasure
      end
      if(number == 6)
        @hiddenTreasures << dealer.nextTreasure
      end
    end
    def getLevels()
      return @level
    end
    def discardAllTreasures()
      auxv = Array.new(@visibleTreasures)
      auxh = Array.new(@hiddenTreasures)
      auxv.each do |treas|
        discardVisibleTreasure(treas)
      end
      auxh.each do |treas|
        discardHiddenTreasure(treas)
      end
    end
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
      return @name.to_s+" de nivel "+@level.to_s()+" que esta muerto: "+@dead.to_s()+"  Cultist: NO"+"\n\t"+"VisibleTreasures: "+ visible +"\n\tHiddenTreasures: " + hidden + "\n\nPendingBadConsequnce: "+mensaje
    end
  end
end
