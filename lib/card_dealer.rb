#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require 'singleton'
require_relative 'bad_consequence.rb'
require_relative 'specific_bad_consequence.rb'
require_relative 'death_bad_consequence.rb'
require_relative 'numeric_bad_consequence.rb'
require_relative 'card_dealer.rb'
require_relative 'monster.rb'
require_relative 'player.rb'
require_relative 'prize.rb'
require_relative 'treasure.rb'
require_relative 'treasure_kind.rb'
require_relative 'cultist.rb'
require_relative 'cultist_player.rb'

module NapakalakiGame
  class CardDealer
    include Singleton
    def initialize
      @unusedMonsters = Array.new
      @usedMonsters = Array.new
      @usedTreasures = Array.new
      @unusedTreasures = Array.new
      @unusedCultist = Array.new
    end
    def shuffleCultists()
      @unusedCultist.shuffle!
    end
    def initCultistCardDeck()
      @unusedCultist << Cultist.new("Agarius",1)
      @unusedCultist << Cultist.new("Boletus",2)
      @unusedCultist << Cultist.new("Dalvinia",1)
      @unusedCultist << Cultist.new("Bolbitius",2)
      @unusedCultist << Cultist.new("Calvatia",1)
      @unusedCultist << Cultist.new("Dermoloma",1)
    end
    def nextCultist()
      return @unusedCultist.delete_at(0)
    end
    def initTreasureCardDeck()
      @unusedTreasures << Treasure.new("¡Sí mi amo!", 4, TreasureKind::HELMET)
      @unusedTreasures << Treasure.new("Botas de investigación",  3, TreasureKind::SHOES)
      @unusedTreasures << Treasure.new("Capucha de Cthulhu", 3, TreasureKind::HELMET)   
      @unusedTreasures << Treasure.new("A prueba de babas", 2, TreasureKind::ARMOR)   
      @unusedTreasures << Treasure.new("Botas de lluvia ácida", 1, TreasureKind::SHOES)   
      @unusedTreasures << Treasure.new("Casco minero", 2, TreasureKind::HELMET)   
      @unusedTreasures << Treasure.new("Ametralladora Thompson", 4, TreasureKind::BOTHHANDS)   
      @unusedTreasures << Treasure.new("Camiseta de la UGR", 1, TreasureKind::ARMOR)   
      @unusedTreasures << Treasure.new("Clavo de rail ferroviario", 3, TreasureKind::ONEHAND)   
      @unusedTreasures << Treasure.new("Cuchillo de sushi arcano", 2, TreasureKind::ONEHAND)   
      @unusedTreasures << Treasure.new("Fez alópodo", 3, TreasureKind::HELMET)   
      @unusedTreasures << Treasure.new("Hacha prehistórica", 2, TreasureKind::ONEHAND)   
      @unusedTreasures << Treasure.new("El aparato del Pr. Tesla", 4, TreasureKind::ARMOR)
      @unusedTreasures << Treasure.new("Gaita", 4, TreasureKind::BOTHHANDS)
      @unusedTreasures << Treasure.new("Insecticida", 2, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("Escopeta de tres cañones", 4,TreasureKind::BOTHHANDS)
      @unusedTreasures << Treasure.new("Garabato místico", 2, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("La rebeca metálica", 2, TreasureKind::ARMOR)
      @unusedTreasures << Treasure.new("Mazo de los antiguos", 3, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("Necroplayboycon", 3, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("Lanzallamas", 4, TreasureKind::BOTHHANDS)
      @unusedTreasures << Treasure.new("Necrocomicón", 1, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("Necronomicón", 5, TreasureKind::BOTHHANDS)
      @unusedTreasures << Treasure.new("Linterna a dos manos", 3, TreasureKind::BOTHHANDS)
      @unusedTreasures << Treasure.new("Necrognomicón", 2, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("Necrotelecom", 2, TreasureKind::HELMET)
      @unusedTreasures << Treasure.new("Porra preternatural", 2, TreasureKind::ONEHAND)
      @unusedTreasures << Treasure.new("Tentáculo de pega", 0, TreasureKind::HELMET)
      @unusedTreasures << Treasure.new("Zapato deja-amigos", 0, TreasureKind::SHOES)
      @unusedTreasures << Treasure.new("Shogulador", 1, TreasureKind::BOTHHANDS)
      @unusedTreasures << Treasure.new("Varita de atizamiento", 3, TreasureKind::ONEHAND)
    end
    def initMonsterCardDeck()
      prize=Prize.new(4,2)
      badConsequence = NumericBadConsequence.new("Pierdes 5 niveles y 3 tesoros visibles", 5, 3, 0)
      @unusedMonsters << Monster.Monster("El rey de la rosa",13,badConsequence,prize)

      prize=Prize.new(2,1)
      badConsequence = SpecificBadConsequence.new("Pierdes tu armadura visible y otra oculta", 0,[TreasureKind::ARMOR], [TreasureKind::ARMOR])
      @unusedMonsters << Monster.Monster("3 Byakhees de bonanza", 8, badConsequence, prize)

      prize=Prize.new(1,1)
      badConsequence = SpecificBadConsequence.new("Embobado con el lindo primigenio te descartas de tu casco visible", 0, [TreasureKind::HELMET],Array.new)
      @unusedMonsters << Monster.Monster("Chibithulhu",2,badConsequence, prize)

      prize=Prize.new(1,1)
      badConsequence = SpecificBadConsequence.new("El primordial bostezo contagioso. Pierdes el calzado visible", 0, [TreasureKind::SHOES],Array.new)
      @unusedMonsters << Monster.Monster("El sopor de Dunwich",2,badConsequence,prize)

      prize=Prize.new(4,1)
      badConsequence = NumericBadConsequence.new("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta", 0, 1, 1)
      @unusedMonsters << Monster.Monster("Ángeles de la noche ibicenca",14,badConsequence,prize)

      prize=Prize.new(3,1)
      badConsequence = NumericBadConsequence.new("Pierdes todos los tesoros visibles", 0, BadConsequence.maxtreasures, 0)
      @unusedMonsters << Monster.Monster("El gorrón en el umbral",10,badConsequence,prize)

      prize=Prize.new(2,1)
      badConsequence = SpecificBadConsequence.new("Pierdes la armadura visible", 0, [TreasureKind::ARMOR], Array.new)
      @unusedMonsters << Monster.Monster("H.P. Munchcraft",6,badConsequence,prize)

      prize=Prize.new(1,1)
      badConsequence = SpecificBadConsequence.new("Sientes bichos bajo la ropa. Descarta la armadura visible", 0, [TreasureKind::ARMOR], Array.new)
      @unusedMonsters << Monster.Monster("Bichgooth",2,badConsequence,prize)

      prize=Prize.new(1,1)
      badConsequence = NumericBadConsequence.new("Toses los pulmones y pierdes 2 niveles", 2, 0, 0)
      @unusedMonsters << Monster.Monster("La que redacta en las tinieblas",2,badConsequence,prize)

      prize=Prize.new(2,1)
      badConsequence = DeathBadConsequence.new("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto")
      @unusedMonsters << Monster.Monster("Los hondos",8,badConsequence,prize)

      prize=Prize.new(2,1)
      badConsequence = NumericBadConsequence.new("Pierdes 2 niveles y 2 tesoros", 2, 0, 2)
      @unusedMonsters << Monster.Monster("Semillas Cthulhu",4,badConsequence,prize)

      prize=Prize.new(2,1)
      badConsequence = NumericBadConsequence.new("Te intentas escaquear. Pierdes una mano visible", 0, 1, 0)
      @unusedMonsters << Monster.Monster("Dameargo",1,badConsequence,prize)

      prize=Prize.new(1,1)
      badConsequence = NumericBadConsequence.new("Da mucho asquito. Pierdes 3 niveles", 3, 0, 0)
      @unusedMonsters << Monster.Monster("Pollipólipo volante",3,badConsequence,prize)

      prize=Prize.new(3,1)
      badConsequence = DeathBadConsequence.new("No le hace gracia que pronuncien mal su nombre. Estas muerto")
      @unusedMonsters << Monster.Monster("Yskhtihyssg-Goth", 12, badConsequence,prize)

      prize=Prize.new(4,1)
      badConsequence = DeathBadConsequence.new("La familia te atrapa. Estas muerto")
      @unusedMonsters << Monster.Monster("Familia feliz",1,badConsequence,prize)

      prize=Prize.new(2,1)
      badConsequence = SpecificBadConsequence.new("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro de 2 manos", 2, [TreasureKind::BOTHHANDS], Array.new)
      @unusedMonsters<< Monster.Monster("Roboggoth",8,badConsequence,prize)

      prize=Prize.new(1,1)
      badConsequence = SpecificBadConsequence.new("Te asusta en la noche. Pierdes un casco visible", 5, [TreasureKind::HELMET], Array.new)
      @unusedMonsters << Monster.Monster("El espía",5,badConsequence,prize)

      prize=Prize.new(1,1)
      badConsequence = NumericBadConsequence.new("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles", 2, 5, 0)
      @unusedMonsters << Monster.Monster("El Lenguas",20,badConsequence,prize)

      prize=Prize.new(1,1)
      badConsequnce = SpecificBadConsequence.new("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesorso visibles de las manos", 3, [TreasureKind::ONEHAND,TreasureKind::ONEHAND,TreasureKind::BOTHHANDS],Array.new)
      @unusedMonsters << Monster.Monster("Bicéfalo",20,badConsequence,prize)

      prize=Prize.new(3,1)
      badConsequnce = SpecificBadConsequence.new("Pierdes una mano visible", 0, [TreasureKind::ONEHAND],Array.new)
      @unusedMonsters << Monster.MonsterC("El mal indecible impronunciable",10,badConsequence,prize,-2)

      prize=Prize.new(2,1)
      badConsequnce = NumericBadConsequence.new("Pierdes tus tesoros visibles. Jajaja", 0,10,0)
      @unusedMonsters << Monster.MonsterC("Testigos Oculares",6,badConsequence,prize,2)
      
      prize=Prize.new(2,5)
      badConsequnce = DeathBadConsequence.new("Hoy no es tu dia de suerte. Mueres")
      @unusedMonsters << Monster.MonsterC("El gran cthulhu",20,badConsequence,prize,4)
      
      prize=Prize.new(2,1)
      badConsequnce = NumericBadConsequence.new("Tu gobierno te recorta 2 niveles", 2,0,0)
      @unusedMonsters << Monster.MonsterC("Testigos Oculares",8,badConsequence,prize,-2)
      
      prize=Prize.new(1,1)
      badConsequnce = SpecificBadConsequence.new("Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas.", 0,[TreasureKind::HELMET,TreasureKind::ARMOR],[TreasureKind::ONEHAND,TreasureKind::ONEHAND,TreasureKind::BOTHHANDS])
      @unusedMonsters << Monster.MonsterC("Felpuggoth",2,badConsequence,prize,5)
      
      prize=Prize.new(4,2)
      badConsequnce = NumericBadConsequence.new("Pierdes dos niveles", 2,0,0)
      @unusedMonsters << Monster.MonsterC("Shoggoth",16,badConsequence,prize,-4)
      
      prize=Prize.new(1,1)
      badConsequnce = NumericBadConsequence.new("Pintalabios negro. Pierdes dos niveles", 2,0,0)
      @unusedMonsters << Monster.MonsterC("Lolitagooth",2,badConsequence,prize,3)
      
    end
    def shuffleTreasures()
      @unusedTreasures.shuffle!
    end
    def shuffleMonsters()
      @unusedMonsters.shuffle!
    end
    def nextTreasure()
      if(@unusedTreasures.length() == 0)
        @usedTreasures.each do |treas|
          @unusedTreasures << @usedTreasures.delete(treas)
        end
        shuffleTreasures
      end
      return @unusedTreasures.delete_at(0)
    end
    def nextMonster()
      if(@unusedMonsters.length() == 0)
        @usedMonster.each do |mons|
          @unusedMonsters << @usedMonster.delete(mons)
        end
        shuffleMonsters
      end
      return @unusedMonsters.delete_at(0)
    end
    def giveTreasureBack(trea)
      @usedTreasures << trea
    end
    def giveMonsterBack(mons)
      @usedMonsters << mons
    end
    def initCards()
      initMonsterCardDeck
      initTreasureCardDeck
      initCultistCardDeck
      shuffleTreasures
      shuffleMonsters
      shuffleCultists
    end
  end
end