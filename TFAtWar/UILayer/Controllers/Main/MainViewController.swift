//
//  MainViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import PATools
import RxSwift

public typealias MainNavigationControllerFactory = () ->  MainNavigationController
public typealias BattlefieldNavigationControllerFactory = () ->  BattlefieldNavigationController

public class MainViewController: NiblessViewController {
    
    // MARK: - Properties
    // ViewModel
    private unowned let viewModel: MainViewModel
    
    // State
    private let disposeBag = DisposeBag()
    
    // Factories
    private let makeMainNavigationController: MainNavigationControllerFactory
    private let makeBattlefieldNavigationController: BattlefieldNavigationControllerFactory
    
    // MARK: - Methods
    init(viewModel: MainViewModel,
         mainNavigationControllerFactory: @escaping MainNavigationControllerFactory,
         battlefieldNavigationControllerFactory: @escaping BattlefieldNavigationControllerFactory) {
        self.viewModel = viewModel
        self.makeMainNavigationController = mainNavigationControllerFactory
        self.makeBattlefieldNavigationController = battlefieldNavigationControllerFactory
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
            presentBattlefieldNavigationController()
        }
    }
    
    func presentMainNavigationController() {
        guard presentedViewController == nil else {
            presentedViewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        let mainNavigationController = makeMainNavigationController()
        addFullScreen(childViewController: mainNavigationController)
    }
    
    func presentBattlefieldNavigationController() {
        let battlefieldNavigationController  = makeBattlefieldNavigationController()
        
        if #available(iOS 13.0, *) {
            battlefieldNavigationController.isModalInPresentation = true
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            battlefieldNavigationController.modalPresentationStyle = .pageSheet
        }
        
        present(battlefieldNavigationController, animated: true, completion: nil)
    }
}
