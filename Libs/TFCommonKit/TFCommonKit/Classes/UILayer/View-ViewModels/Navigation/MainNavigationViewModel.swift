//
//  MainNavigationViewModel.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import RxSwift
import TFData

public typealias MainNavigationAction = NavigationAction<MainNavigationView>

public class MainNavigationViewModel {
    
    // MARK: - Properties
    private unowned let goToBattlefieldNavigator: GoToBattlefieldNavigator
    
    // MARK: State
    public var navigationAction: Observable<MainNavigationAction> {
        return _navigationAction.asObservable()
    }
    private let _navigationAction = BehaviorSubject<MainNavigationAction>(value: .present(view: .list))
    
    // MARK: - Init
    public init(goToBattlefieldNavigator: GoToBattlefieldNavigator) {
        self.goToBattlefieldNavigator = goToBattlefieldNavigator
    }
}

// MARK: - Actions
extension MainNavigationViewModel {
    public func uiPresented(mainNavigationView: MainNavigationView) {
        _navigationAction.onNext(.presented(view: mainNavigationView))
    }
}

// MARK: - Responders
extension MainNavigationViewModel: ShowAddScreenResponder {
    public func showAddScreen(transformer: TransformerData?) {
        _navigationAction.onNext(.present(view: .add(transformer: transformer)))
    }
}
