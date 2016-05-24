# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require 'singleton'
require_relative 'treasure.rb'
require_relative 'combat_result.rb'
require_relative 'card_dealer.rb'

module NapakalakiGame
  class Napakalaki
    include Singleton
    def initialize
      @currentPlayerIndex = -1;
      @currentMonster = nil
      @dealer = CardDealer.instance
      @currentPlayer = nil
      @players = Array.new
    end
    def initPlayers(names)
      names.each do |name|
        @players << Player.new(name)
      end
    end
    def nextPlayer()
      if(@currentPlayerIndex == -1)
        @currentPlayerIndex = rand(@players.length - 1)
      else
        @currentPlayerIndex += 1
        if(@currentPlayerIndex >= @players.length)
          @currentPlayerIndex = 0
        end
      end
      @currentPlayer = @players.at(@currentPlayerIndex)
      return @currentPlayer
    end
    def nextTurnAllowed()
      if(@currentPlayer != nil)
        return @currentPlayer.validState()
      else
        return false;
      end
    end
    def developCombat()
      combatresult = @currentPlayer.combat(@currentMonster)
      @dealer.giveMonsterBack(@currentMonster)
      if(combatresult == CombatResult::LOSEANDCONVERT)
        aux = CultistPlayer.new(@currentPlayer,@dealer.nextCultist)
        @players.delete(@currentPlayer)
        @currentPlayer = aux
        @players << aux
      end
      return combatresult
    end
    def discardVisibleTreasures(treasures)
      treasures.each do |treas|
        @currentPlayer.discardVisibleTreasure(treas)
      end
    end
    def discardHiddenTreasures(treasures)
      treasures.each do |treas|
        @currentPlayer.discardHiddenTreasure(treas)
      end
    end
    def makeTreasuresVisible(treasures)
      treasures.each do |treas|
        @currentPlayer.makeTreasureVisible(treas)
      end
    end
    def initGame(players)
      initPlayers(players)
      @dealer.initCards
      nextTurn
    end
    def getCurrentPlayer()
      return @currentPlayer
    end
    def getCurrentMonster()
      return @currentMonster
    end
    def nextTurn()
      stateOK=true
      if(@currentPlayer != nil)
        stateOK=nextTurnAllowed()
      end
      if(stateOK)
        @currentMonster = @dealer.nextMonster
        @currentPlayer = nextPlayer
        if(@currentPlayer.isDead)
          @currentPlayer.initTreasures
        end
      end
    return stateOK
    end
    def endOfGame(result)
      return result == CombatResult::WINGAME
    end
  end
end
