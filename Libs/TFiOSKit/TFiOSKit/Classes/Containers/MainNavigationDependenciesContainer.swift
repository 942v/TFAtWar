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

// MARK: - Main Navigation
extension MainNavigationDependenciesContainer {
    func makeMainNavigationController() -> MainNavigationController {
        let viewModel = sharedMainNavigationViewModel
        
        let listTableViewController = makeListTableViewController()

        func addViewControllerFactory(transformer: TransformerData?) -> AddViewController {
            return makeAddViewController(transformer: transformer)
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
        let viewModel = sharedMainNavigationViewModel
        
        return ListViewModel(transformerDataRepository: transformerDataRepository,
                             showAddScreenResponder: viewModel)
    }
    
    func makeListTableViewController() -> ListTableViewController {
        
        let listTableViewController = ListTableViewController.instantiate(from: .listStoryboard, framework: "TFiOSKit")
        
        listTableViewController.inject(viewModelFactory: self)
        
        return listTableViewController
    }
}

// MARK: - Add
extension MainNavigationDependenciesContainer: AddViewModelFactory {
    
    public func makeAddViewModel(transformer: TransformerData?) -> AddViewModel {
        let transformerDataRepository = sharedTransformersDataRepository
//        let viewModel = sharedMainNavigationViewModel
        return AddViewModel(transformerDataRepository: transformerDataRepository,
                            transformer: transformer)
    }
    
    func makeAddViewController(transformer: TransformerData?) -> AddViewController {
        
        let addViewController = AddViewController.instantiate(from: .addStoryboard, framework: "TFiOSKit")
        
        addViewController.inject(viewModel: makeAddViewModel(transformer: transformer))
        
        return addViewController
    }
}
