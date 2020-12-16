//
//  AddRootNavigationItem.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import RxSwift
import RxCocoa

class AddRootNavigationItem: UINavigationItem {
    
    // MARK: - Properties
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var createBarButton: UIBarButtonItem!
    
    // ViewModel
    private unowned var viewModel: AddViewModel!
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: AddViewModel) {
        self.viewModel = viewModel
        
        setup()
        
        bindViews()
    }

    private func setup() {
        title = viewModel.title()
    }
}

// MARK: - Bindings
extension AddRootNavigationItem {
    func bindViews() {
        viewModel
            .barButtonsEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(cancelBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel
            .barButtonsEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(createBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension AddRootNavigationItem {
    
    @IBAction func doCancelAction(_ sender: Any) {
        viewModel.cancel()
    }
    
    @IBAction func doSaveAction(_ sender: Any) {
        viewModel.save()
    }
}
