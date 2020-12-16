//
//  MainNavigationDependenciesContainer.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public class MainNavigationDependenciesContainer {
    
    private unowned let sharedTransformersDataRepository: TransformersDataRepositoryProtocol
    private unowned let sharedMainViewModel: MainViewModel
    private let sharedMainNavigationViewModel: MainNavigationViewModel
    private let sharedListViewModel: ListViewModel
    
    public init(appDependencyContainer: AppDependenciesContainer) {
        
        func makeMainNavigationViewModel(goToBattlefieldNavigator: GoToBattlefieldNavigator) -> MainNavigationViewModel {
            
            return MainNavigationViewModel(goToBattlefieldNavigator: goToBattlefieldNavigator)
        }
        
        func makeListViewModel(transformerDataRepository: TransformersDataRepositoryProtocol,
                               battlefieldNavigator: GoToBattlefieldNavigator,
                               addScreenResponder: AddScreenResponder) -> ListViewModel {
            
            return ListViewModel(transformerDataRepository: transformerDataRepository,
                                 battlefieldNavigator: battlefieldNavigator,
                                 addScreenResponder: addScreenResponder)
        }
        
        self.sharedTransformersDataRepository = appDependencyContainer.sharedTransformersDataRepository
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedMainNavigationViewModel = makeMainNavigationViewModel(goToBattlefieldNavigator: sharedMainViewModel)
        self.sharedListViewModel = makeListViewModel(transformerDataRepository: sharedTransformersDataRepository,
                                                     battlefieldNavigator: sharedMainViewModel,
                                                     addScreenResponder: sharedMainNavigationViewModel)
    }
}

// MARK: - Main Navigation
extension MainNavigationDependenciesContainer {
    func makeMainNavigationController() -> MainNavigationController {
        let viewModel = sharedMainNavigationViewModel
        
        let listTableViewController = makeListTableViewController()

        func addNavigationControllerFactory(transformer: TransformerData?) -> AddNavigationController {
            return makeAddNavigationController(transformer: transformer)
        }
        
        return MainNavigationController(viewModel: viewModel,
                                        listTableViewController: listTableViewController,
                                        makeAddNavigationController: addNavigationControllerFactory)
    }
}

// MARK: - List
extension MainNavigationDependenciesContainer {
    
    func makeListTableViewController() -> ListTableViewController {
        
        let listTableViewController = ListTableViewController.instantiate(from: .listStoryboard)
        
        let viewModel = sharedListViewModel
        
        listTableViewController.inject(viewModel: viewModel)
        
        return listTableViewController
    }
}

// MARK: - Add
extension MainNavigationDependenciesContainer: AddViewModelFactory {
    
    public func makeAddViewModel(transformer: TransformerData?) -> AddViewModel {
        let transformerDataRepository = sharedTransformersDataRepository
        let listViewModel = sharedListViewModel
        return AddViewModel(transformerDataRepository: transformerDataRepository,
                            didFinishAddResponder: listViewModel,
                            transformer: transformer)
    }
    
    func makeAddViewController(transformer: TransformerData?) -> AddViewController {
        
        let addViewController = AddViewController.instantiate(from: .addStoryboard)
        
        let viewModel = makeAddViewModel(transformer: transformer)
        
        addViewController.inject(viewModel: viewModel)
        
        return addViewController
    }
    
    func makeAddNavigationViewModel() -> AddNavigationViewModel {
        return AddNavigationViewModel()
    }
    
    func makeAddNavigationController(transformer: TransformerData?) -> AddNavigationController {
        let viewModel = makeAddNavigationViewModel()
        let addViewController = makeAddViewController(transformer: transformer)
        
        return AddNavigationController(viewModel: viewModel, addViewController: addViewController)
    }
}

// MARK: - BattlefieldResponder
extension MainNavigationDependenciesContainer: BattlefieldResponder {
    public func transformersForBattle() -> [TransformerData] {
        sharedListViewModel.allTransformers()
    }
}
