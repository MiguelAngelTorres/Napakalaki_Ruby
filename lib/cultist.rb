# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame
  class Cultist
    def initialize(nam, gainedLvl)
      @name = nam
      @gainedLevels = gainedLvl
    end
    def getGainedLevels()
      return @gainedLevels
    end
    def to_s()
      return @name.to_s+"(+"+@gainedLevels.to_s()+")"
    end
  end
end
