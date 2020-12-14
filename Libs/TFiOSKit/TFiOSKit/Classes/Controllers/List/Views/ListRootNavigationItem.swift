//
//  ListRootNavigationItem.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import TFCommonKit
import RxSwift

class ListRootNavigationItem: UINavigationItem {
    
    // MARK: - Properties
    @IBOutlet weak var battleBarButton: UIBarButtonItem!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    // ViewModel
    private unowned var viewModel: ListViewModel!
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: ListViewModel) {
        self.viewModel = viewModel
        
        setup()
        
        bindViews()
    }

    private func setup() {
        title = viewModel.title()
    }
}

// MARK: - Bindings
extension ListRootNavigationItem {
    func bindViews() {
        viewModel
            .barButtonsEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(battleBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel
            .barButtonsEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(refreshBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel
            .barButtonsEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(addBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension ListRootNavigationItem {
    @IBAction func doBattleAction(_ sender: Any) {
        viewModel.showBattlefield()
    }
    
    @IBAction func doRefreshAction(_ sender: Any) {
        viewModel.loadData()
    }
    
    @IBAction func doAddAction(_ sender: Any) {
        viewModel.showAddTransformer()
    }
}
