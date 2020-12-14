//
//  BattlefieldViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import TFData
import TFCommonKit
import RxSwift

public class BattlefieldViewController: UIViewController {
    
    // MARK: - Properties
    
    // ViewModel
    private var viewModel: BattlefieldViewModel!
    
    // ViewControllers
    
    // State
    private let disposeBag = DisposeBag()
    
    // Factories
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: BattlefieldViewModel) {
        self.viewModel = viewModel
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigationItem = navigationItem as? BattlefieldRootNavigationItem else {
            return
        }
        
        observeViewModel()

        navigationItem.inject(viewModel: viewModel)
    }
}

// MARK: - Bindings
private extension BattlefieldViewController {
    
    private func observeViewModel() {
        
        let observable = viewModel.view.distinctUntilChanged()
        subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<BattlefieldView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState(view)
        }).disposed(by: disposeBag)
    }
}

// MARK: - UI
private extension BattlefieldViewController {
    
    func updateViewState(_ view: BattlefieldView) {
        switch view {
        case .failure(let error):
            showErrorView(for: error)
        default:
            return
        }
    }
    
    func showErrorView(for error: ErrorMessage) {
        let alertController = UIAlertController.errorAlert(title: error.title, message: error.message)
        present(alertController, animated: true, completion: nil)
    }
}
