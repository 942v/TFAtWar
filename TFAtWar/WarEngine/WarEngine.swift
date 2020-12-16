//
//  WarEngine.swift
//  TFWarEngine
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import Foundation

public class WarEngine {
    
    // Properties
    private(set) var autobots = [TransformerData]()
    private(set) var decepticons = [TransformerData]()
    
    private let battleField = BattleField()
    
    /**
     When we initialize we also sort and order the collection
     - Parameter transformers: the collection to be used in the battle
     */
    
    public required init(transformers: [TransformerData]) {
        
        // Creating groups
        transformers.forEach {
            if $0.team == .autobot {
                autobots.append($0)
            }else{
                decepticons.append($0)
            }
        }
        
        // Sorting groups by rank
        autobots.sort{ $0.rank > $1.rank }
        decepticons.sort{ $0.rank > $1.rank }
    }
}

extension WarEngine {
    /**
     Starts the battle between autobots and decepticons
     - Returns: (optional) number of battles, winnerTeam, winners, loserTeam, losers.
     */
    public func startBattle() -> (battles: Int,
                                  winnerTeam: TransformerTeam,
                                  winners: [TransformerData],
                                  loserTeam: TransformerTeam,
                                  losers: [TransformerData])? {
        
        var autobotsIndex = 0
        var autobotsWins = 0
        var decepticonsIndex = 0
        var decepticonsWins = 0
        
        // We iterate until we are out of index
        while autobotsIndex<autobots.count && decepticonsIndex<decepticons.count {
            let autobot = autobots[autobotsIndex]
            let decepticon = decepticons[decepticonsIndex]
            
            // We start a battle between 2 players
            battleField.setPlayers(autobot: autobot, decepticon: decepticon)
            let fightResult = battleField.fight()
            
            switch fightResult.result {
            case .totalDestruction:
                // End all
                return nil
            case .none:
                // Both were destroyed
                autobots.remove(at: autobotsIndex)
                decepticons.remove(at: decepticonsIndex)
                continue
            case .winner:
                // If there's a winner then we are always going to have an actual winner. That's why we can force the variable
                let winner = fightResult.winner!
                if winner.team == .autobot {
                    autobotsWins += 1
                    decepticons.remove(at: decepticonsIndex)
                }else{
                    decepticonsWins += 1
                    autobots.remove(at: autobotsIndex)
                }
            }
            autobotsIndex += 1
            decepticonsIndex += 1
        }
        
        var battles: Int
        var winnerTeam: TransformerTeam
        var winners: [TransformerData]
        var loserTeam: TransformerTeam
        var losers: [TransformerData]
        
        // Assumption: if it's a tie then no one won
        guard autobotsWins != decepticonsWins else {
            return nil
        }
        
        // At this point we know it's not a tie and one team won
        // If autobot has more wines then they won
        if autobotsWins>decepticonsWins {
            battles = autobotsWins
            winnerTeam = .autobot
            loserTeam = .decepticon
            winners = autobots
            losers = decepticons
        }else {
            battles = decepticonsWins
            winnerTeam = .decepticon
            loserTeam = .autobot
            winners = decepticons
            losers = autobots
        }
        // Return result
        return (battles,
                winnerTeam,
                winners,
                loserTeam,
                losers)
    }
}
