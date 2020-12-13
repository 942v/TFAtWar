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
    }

    private func setup() {
        title = viewModel.title()
    }
}

// MARK: - Actions
extension ListRootNavigationItem {
    @IBAction func doBattleAction(_ sender: Any) {
//        viewModel.didFinishAddingRadios()
    }
    
    @IBAction func doRefreshAction(_ sender: Any) {
        viewModel.loadData()
    }
    
    @IBAction func doAddAction(_ sender: Any) {
        viewModel.showAddTransformer()
    }
}
