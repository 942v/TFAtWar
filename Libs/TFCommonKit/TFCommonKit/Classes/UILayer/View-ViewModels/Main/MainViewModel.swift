//
//  MainViewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import RxSwift

public class MainViewModel {
    
    // MARK: - Properties
    // MARK: State
    private let viewSubject = BehaviorSubject<MainView>(value: .mainNavigationController)
    public var view: Observable<MainView> {
        return viewSubject.asObservable()
    }
    
    // MARK: - Init
    public init() {}
}

// MARK: - GoToBattlefieldNavigator
extension MainViewModel: GoToBattlefieldNavigator {
    public func navigateToBattlefield() {
        viewSubject.onNext(.battlefield)
    }
    
    // TODO: add remove action
}
