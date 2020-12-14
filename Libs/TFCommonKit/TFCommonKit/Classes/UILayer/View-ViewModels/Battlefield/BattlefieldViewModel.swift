//
//  BattlefieldViewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import Foundation
import RxSwift

public class BattlefieldViewModel {
    
    // MARK: - Properties
    private unowned let battlefieldNavigator: GoToBattlefieldNavigator
    
    // MARK: State
    private let viewSubject = BehaviorSubject<BattlefieldView>(value: .idle)
    public let barButtonsEnabled = BehaviorSubject<Bool>(value: true)
    public var view: Observable<BattlefieldView> {
        return viewSubject.asObservable()
    }
    
    // MARK: - Init
    public init(battlefieldNavigator: GoToBattlefieldNavigator) {
        self.battlefieldNavigator = battlefieldNavigator
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
        
    }
}
