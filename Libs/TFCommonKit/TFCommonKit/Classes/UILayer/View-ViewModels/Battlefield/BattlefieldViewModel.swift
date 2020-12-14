//
//  BattlefieldViewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import Foundation
import TFData
import TFWarEngine
import RxSwift

public class BattlefieldViewModel {
    
    // MARK: - Properties
    private unowned let battlefieldNavigator: GoToBattlefieldNavigator
    private let warEngine: WarEngine
    
    // MARK: State
    private let viewSubject = BehaviorSubject<BattlefieldView>(value: .idle)
    public let barButtonsEnabled = BehaviorSubject<Bool>(value: true)
    public var view: Observable<BattlefieldView> {
        return viewSubject.asObservable()
    }
    
    // MARK: - Init
    public init(battlefieldNavigator: GoToBattlefieldNavigator,
                warEngine: WarEngine) {
        self.battlefieldNavigator = battlefieldNavigator
        self.warEngine = warEngine
    }
}

// MARK: - Actions
extension BattlefieldViewModel {
    public func title() -> String {
        return "Battlefield"
    }
    
    public func cancel() {
        battlefieldNavigator.dismissBattlefield()
    }
    
    public func startMatch() {
        let result = warEngine.startBattle()
        let resultInfo = info(for: result)
        self.barButtonsEnabled.onNext(false)
        self.viewSubject.onNext(.result(resultInfo))
    }
}

extension BattlefieldViewModel {
    
    private func info(for result: (battles: Int,
                                   winnerTeam: TransformerTeam,
                                   winners: [TransformerData],
                                   loserTeam: TransformerTeam,
                                   losers: [TransformerData])?) -> String {
        
        guard let result = result else {
            return "Battle field destroyed!\nAll competitor destroyed!"
        }
        
        let battles = result.battles
        let winnerTeam = result.winnerTeam
        let winners = result.winners
        let loserTeam = result.loserTeam
        let losers = result.losers
        
        let winnerTeamName = name(winnerTeam)
        let winnersNames = teammates(winners)
        let loserTeamName = name(loserTeam)
        let losersNames = teammates(losers)
        
        let battlesLine = "\(battles) battle\(battles != 1 ? "s":"")"
        let winnersLine = "Winning team (\(winnerTeamName)): " + winnersNames
        let losersLine = "Losing team (\(loserTeamName)): " + losersNames
        
        return battlesLine +
            "\n\n" +
            winnersLine +
            "\n\n" +
            losersLine
    }
    
    private func name(_ team: TransformerTeam) -> String {
        switch team {
        case .autobot:
            return "Autobots"
        case .decepticon:
            return "Decepticons"
        default:
            fatalError("Winners or losers should always be passed")
        }
    }
    
    private func teammates(_ transformers: [TransformerData]) -> String {
        transformers.reduce("", {
            let name = $1.name
            
            guard $0.count > 0 else {
                return name
            }
            
            return $0 + ", " + name
        })
    }
}
