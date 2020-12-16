//
//  BattlefieldRootNavigationItem.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import RxSwift
import RxCocoa

class BattlefieldRootNavigationItem: UINavigationItem {
    
    // MARK: - Properties
    @IBOutlet weak var goBackBarButton: UIBarButtonItem!
    @IBOutlet weak var startBarButton: UIBarButtonItem!
    
    // ViewModel
    private unowned var viewModel: BattlefieldViewModel!
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: BattlefieldViewModel) {
        self.viewModel = viewModel
        
        setup()
        
        bindViews()
    }

    private func setup() {
        title = viewModel.title()
    }
}

// MARK: - Bindings
extension BattlefieldRootNavigationItem {
    func bindViews() {
        viewModel
            .barButtonsEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(startBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension BattlefieldRootNavigationItem {
    
    @IBAction func doEndAction(_ sender: Any) {
        viewModel.cancel()
    }
    
    @IBAction func doStartAction(_ sender: Any) {
        viewModel.startMatch()
    }
}
