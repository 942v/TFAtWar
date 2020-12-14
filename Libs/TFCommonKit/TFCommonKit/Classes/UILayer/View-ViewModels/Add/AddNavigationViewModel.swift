//
//  AddNavigationViewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import RxSwift

public typealias AddNavigationAction = NavigationAction<AddNavigationView>

public class AddNavigationViewModel {
    
    // MARK: - Properties
    
    // MARK: State
    public var navigationAction: Observable<AddNavigationAction> {
        return _navigationAction.asObservable()
    }
    private let _navigationAction = BehaviorSubject<AddNavigationAction>(value: .present(view: .form))
    
    // MARK: - Init
    public init() {
    }
}

// MARK: - Actions
extension AddNavigationViewModel {
    public func uiPresented(addNavigationView: AddNavigationView) {
        _navigationAction.onNext(.presented(view: addNavigationView))
    }
}
