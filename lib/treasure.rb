# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  class Treasure
    def initialize(name, bonus, kind)
      @type = kind
      @name = name
      @bonus = bonus 
    end
    def getName()
      return @name
    end
    def getBonus()
      return @bonus
    end
    def getType()
      return @type
    end
    def to_s()
      return @name.to_s + "[" + @type.to_s + "]" + "(+" + @bonus.to_s+")"
    end
  end
end
