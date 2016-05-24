# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'bad_consequence.rb'
require_relative 'numeric_bad_consequence.rb'
require_relative 'player.rb'

module NapakalakiGame
  class DeathBadConsequence < NumericBadConsequence
    def initialize(text)
      super(text,Player.maxlevel,BadConsequence.maxtreasures,BadConsequence.maxtreasures)
    end
  end
end
