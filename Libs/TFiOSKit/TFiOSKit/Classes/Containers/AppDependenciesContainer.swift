//
//  AppDependenciesContainer.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import TFData
import TFCommonKit

public class AppDependenciesContainer {
    
    let sharedTransformersDataRepository: TransformersDataRepositoryProtocol
    
    let sharedMainViewModel: MainViewModel
    
    public init() {
        
        func makeTransformersDataStore() -> TransformersDataStoreProtocol {
            
            return TransformersUserDefaultsDataStore()
        }
        
        func makeTransformersDataRemoteAPI() -> TransformersDataRemoteAPIProtocol {
            
            return TransformersDataRemoteAPI()
        }
        
        func makeTransformersDataRepository() -> TransformersDataRepositoryProtocol {
            let transformersDataStore = makeTransformersDataStore()
            let transformersDataRemoteAPI = makeTransformersDataRemoteAPI()
            
            return TransformersDataRepository(transformersDataStore: transformersDataStore,
                                              transformersDataRemoteAPI: transformersDataRemoteAPI)
        }
        
        sharedTransformersDataRepository = makeTransformersDataRepository()
        
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        
        sharedMainViewModel = makeMainViewModel()
    }
}

// MARK: - Main
extension AppDependenciesContainer {
    
    public func makeMainViewController() -> MainViewController {
        
        let viewModel = sharedMainViewModel
        let mainNavigationControllerFactory = makeMainNavigationController
        let battlefieldNavigationControllerFactory = makeBattlefieldNavigationController
        
        let mainViewController = MainViewController(viewModel: viewModel,
                                                    mainNavigationControllerFactory: mainNavigationControllerFactory,
                                                    battlefieldNavigationControllerFactory: battlefieldNavigationControllerFactory)
        
        return mainViewController
    }
}

// MARK: - Main navigation
extension AppDependenciesContainer {
    func makeMainNavigationController() -> MainNavigationController {
        let mainNavigationDependenciesContainer = MainNavigationDependenciesContainer(appDependencyContainer: self)
        return mainNavigationDependenciesContainer.makeMainNavigationController()
    }
}

// MARK: - Battlefield navigation
extension AppDependenciesContainer {
    func makeBattlefieldNavigationController() -> BattlefieldNavigationController {
        let viewModel = makeBattlefieldNavigationViewModel()
        let battlefieldViewController = makeBattlefieldViewController()
        
        let battlefieldNavigationController = BattlefieldNavigationController(viewModel: viewModel,
                                                                              battlefieldViewController: battlefieldViewController)
        
        return battlefieldNavigationController
    }
    
    func makeBattlefieldNavigationViewModel() -> BattlefieldNavigationViewModel {
        return BattlefieldNavigationViewModel()
    }
    
    func makeBattlefieldViewModel() -> BattlefieldViewModel {
        let mainViewModel = sharedMainViewModel
        return BattlefieldViewModel(battlefieldNavigator: mainViewModel)
    }
    
    func makeBattlefieldViewController() -> BattlefieldViewController {
        
        let battlefieldViewController = BattlefieldViewController.instantiate(from: .battelfieldStoryboard, framework: "TFiOSKit")
        
        let viewModel = makeBattlefieldViewModel()
        
        battlefieldViewController.inject(viewModel: viewModel)
        
        return battlefieldViewController
    }
}
