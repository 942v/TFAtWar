//
//  Battlefield.swift
//  TFWarEngine
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import Foundation

fileprivate enum SpecialPlayers: String {
    case optimus = "Optimus Prime"
    case predaking = "Predaking"
}

enum Result {
    case totalDestruction
    case none
    case winner
}

class BattleField {
    
    private var autobot: TransformerData?
    private var decepticon: TransformerData?
    
    /**
     Sets the palyers to battle
     - Parameter autobot: Autobot player
     - Parameter decepticon: Decepticon player
     */
    func setPlayers(autobot: TransformerData,
                    decepticon: TransformerData) {
        self.autobot = autobot
        self.decepticon = decepticon
    }
}

extension BattleField {
    
    /**
     Starts the fight between players
     - Returns: a `result` and the actual `winner`as an optional. If the `result` is not .winner then no `winner` will be returned
     */
    public func fight() -> (result: Result, winner: TransformerData?) {
        
        guard var autobot = autobot,
              var decepticon = decepticon else {
            fatalError("Can't start a fight without both players")
        }
        
        let autobotIsSpecial = isSpecialPlayer(autobot)
        let decepticonIsSpecial = isSpecialPlayer(decepticon)
        
        // In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed
        if autobotIsSpecial == true &&
            decepticonIsSpecial == true {
            return (.totalDestruction, nil)
        }
        
        // Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
        guard autobotIsSpecial == false else {
            return (.winner, autobot)
        }
        
        guard decepticonIsSpecial == false else {
            return (.winner, decepticon)
        }
        
        if let winnerByFear = winnerByFear(autobot: autobot,
                                           decepticon: decepticon) {
            return (.winner, winnerByFear)
        }
        
        if let winnerBySkills = winnerBySkills(autobot: autobot,
                                               decepticon: decepticon) {
            return (.winner, winnerBySkills)
        }
        
        // In the event of a tie, both Transformers are considered destroyed
        if autobot.overallRating == decepticon.overallRating {
            return (.none, nil)
        }
        
        // The winner is the Transformer with the highest overall rating
        let winnerByOverallRating = autobot.overallRating > decepticon.overallRating ? autobot : decepticon
        
        return (.winner, winnerByOverallRating)
    }
}

extension BattleField {
    func isSpecialPlayer(_ transformer: TransformerData) -> Bool {
        transformer.name == SpecialPlayers.optimus.rawValue || transformer.name == SpecialPlayers.predaking.rawValue
    }
    
    func winnerByFear(autobot: TransformerData,
                      decepticon: TransformerData) -> TransformerData? {
        
        //If any fighter is down 4 or more points of courage and 3 or more points of strength
        //compared to their opponent, the opponent automatically wins the face-off regardless of
        //overall rating (opponent has ran away)
        func courageWinner() -> (Int, TransformerData) {
            let difference = abs(autobot.courage - decepticon.courage)
            let winner = autobot.courage > decepticon.courage ? autobot : decepticon
            return (difference, winner)
        }
        
        func strengthWinner() -> (Int, TransformerData) {
            let difference = abs(autobot.strength - decepticon.strength)
            let winner = autobot.strength > decepticon.strength ? autobot : decepticon
            return (difference, winner)
        }
        
        let courageResult = courageWinner()
        let strengthResult = strengthWinner()
        
        //If any fighter is down 4 or more points of courage
        guard courageResult.0 >= 4 else {
            return nil
        }
        
        //and 3 or more points of strength
        guard strengthResult.0 >= 3 else {
            return nil
        }
        
        guard courageResult.1 == strengthResult.1 else {
            return nil
        }
        
        return courageResult.1
    }
    
    func winnerBySkills(autobot: TransformerData,
                        decepticon: TransformerData) -> TransformerData? {
        
        //Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they
        //win the fight regardless of overall rating
        guard abs(autobot.skill - decepticon.skill) < 3 else {
            return autobot.skill > decepticon.skill ? autobot : decepticon
        }
        
        return nil
    }
}
