//
//  MainViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import PATools
import TFCommonKit
import RxSwift

public typealias MainNavigationControllerFactory = () ->  MainNavigationController

public class MainViewController: NiblessViewController {
    
    // MARK: - Properties
    // ViewModel
    private unowned let viewModel: MainViewModel
    
    // State
    private let disposeBag = DisposeBag()
    
    // Factories
    private let makeMainNavigationController: MainNavigationControllerFactory
    
    // MARK: - Methods
    init(viewModel: MainViewModel,
         mainNavigationControllerFactory: @escaping MainNavigationControllerFactory) {
        self.viewModel = viewModel
        self.makeMainNavigationController = mainNavigationControllerFactory
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
    }
}

// MARK: - State
extension MainViewController {
    
    private func observeViewModel() {
      let observable = viewModel.view.distinctUntilChanged()
      subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<MainView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.present(view)
        }).disposed(by: disposeBag)
    }
    
    func present(_ view: MainView) {
        switch view {
        case .mainNavigationController:
            presentMainNavigationController()
        case .battlefield:
            print("Should show battlefield")
        }
    }
    
    func presentMainNavigationController() {
        let mainNavigationController = makeMainNavigationController()
        addFullScreen(childViewController: mainNavigationController)
    }
}
