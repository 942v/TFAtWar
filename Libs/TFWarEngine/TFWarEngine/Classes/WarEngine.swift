//
//  WarEngine.swift
//  TFWarEngine
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import Foundation
import TFData

public class WarEngine {
    
    private(set) var autobots = [TransformerData]()
    private(set) var decepticons = [TransformerData]()
    
    private let battleField = BattleField()
    
    public required init(transformers: [TransformerData]) {
        
        // Creating groups
        transformers.forEach {
            if $0.team == .autobot {
                autobots.append($0)
            }else{
                decepticons.append($0)
            }
        }
        
        // Sorting groups
        autobots.sort{ $0.rank > $1.rank }
        decepticons.sort{ $0.rank > $1.rank }
    }
}

extension WarEngine {
    public func startBattle() -> (battles: Int,
                                  winnerTeam: TransformerTeam,
                                  winners: [TransformerData],
                                  loserTeam: TransformerTeam,
                                  losers: [TransformerData])? {
        
        var autobotsIndex = 0
        var autobotsWins = 0
        var decepticonsIndex = 0
        var decepticonsWins = 0
        while autobotsIndex<autobots.count && decepticonsIndex<decepticons.count {
            let autobot = autobots[autobotsIndex]
            let decepticon = decepticons[decepticonsIndex]
            
            battleField.setPlayers(autobot: autobot, decepticon: decepticon)
            let fightResult = battleField.fight()
            
            switch fightResult.result {
            case .totalDestruction:
                // End all
                return nil
            case .none:
                autobots.remove(at: autobotsIndex)
                decepticons.remove(at: decepticonsIndex)
                continue
            case .winner:
                // It's safe to force because in the case of winner we are always going to receive a transformer
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
        
        guard autobotsWins != decepticonsWins else {
            return nil
        }
        
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
        return (battles,
                winnerTeam,
                winners,
                loserTeam,
                losers)
    }
}
