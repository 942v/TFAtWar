//
//  BattlefieldNavigationViewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import RxSwift

public typealias BattlefieldNavigationAction = NavigationAction<BattlefieldNavigationView>

public class BattlefieldNavigationViewModel {
    
    // MARK: - Properties
    
    // MARK: State
    public var navigationAction: Observable<BattlefieldNavigationAction> {
        return _navigationAction.asObservable()
    }
    private let _navigationAction = BehaviorSubject<BattlefieldNavigationAction>(value: .present(view: .battlefield))
    
    // MARK: - Init
    public init() {
    }
}

// MARK: - Actions
extension BattlefieldNavigationViewModel {
    public func uiPresented(battlefieldNavigationView: BattlefieldNavigationView) {
        _navigationAction.onNext(.presented(view: battlefieldNavigationView))
    }
}
