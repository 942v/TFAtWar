//
//  MainNavigationDependenciesContainer.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import TFData
import TFCommonKit

public class MainNavigationDependenciesContainer {
    
    private unowned let sharedTransformersDataRepository: TransformersDataRepositoryProtocol
    private unowned let sharedMainViewModel: MainViewModel
    private let sharedMainNavigationViewModel: MainNavigationViewModel
    
    public init(appDependencyContainer: AppDependenciesContainer) {
        
        func makeMainNavigationViewModel(goToBattlefieldNavigator: GoToBattlefieldNavigator) -> MainNavigationViewModel {
            
            return MainNavigationViewModel(goToBattlefieldNavigator: goToBattlefieldNavigator)
        }
        
        self.sharedTransformersDataRepository = appDependencyContainer.sharedTransformersDataRepository
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedMainNavigationViewModel = makeMainNavigationViewModel(goToBattlefieldNavigator: sharedMainViewModel)
    }
}

// MARK: - Onboarding
extension MainNavigationDependenciesContainer {
    func makeMainNavigationController() -> MainNavigationController {
        let viewModel = sharedMainNavigationViewModel
        
        let listTableViewController = makeListTableViewController()

        let addViewControllerFactory = {
            return self.makeAddViewController()
        }
        
        return MainNavigationController(viewModel: viewModel,
                                        listTableViewController: listTableViewController,
                                        makeAddViewController: addViewControllerFactory)
    }
}

// MARK: - List
extension MainNavigationDependenciesContainer: ListViewModelFactory {
    
    public func makeListViewModel() -> ListViewModel {
        let transformerDataRepository = sharedTransformersDataRepository
//        let viewModel = sharedMainNavigationViewModel
        return ListViewModel(transformerDataRepository: transformerDataRepository)
    }
    
    func makeListTableViewController() -> ListTableViewController {
        
        let listTableViewController = ListTableViewController.instantiate(from: .listStoryboard, framework: "TFiOSKit")
        
        listTableViewController.inject(viewModelFactory: self)
        
        return listTableViewController
    }
}

// MARK: - Add
extension MainNavigationDependenciesContainer: AddViewModelFactory {
    
    public func makeAddViewModel() -> AddViewModel {
        let transformerDataRepository = sharedTransformersDataRepository
//        let viewModel = sharedMainNavigationViewModel
        return AddViewModel(transformerDataRepository: transformerDataRepository)
    }
    
    func makeAddViewController() -> AddViewController {
        
        let addViewController = AddViewController.instantiate(from: .addStoryboard, framework: "TFiOSKit")
        
        addViewController.inject(viewModelFactory: self)
        
        return addViewController
    }
}
