# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
  class Dice
    @@instance = Dice.new
    def initialize
      
    end
    def self.instance()
      return @@instance
    end
    def nextNumber()
      return 1 + rand(6)
    end
    private_class_method :new
  end
end
