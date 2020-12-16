//
//  ListTableViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import RxSwift

public class ListTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var rootView: ListRootTableView!
    private weak var alertController: UIAlertController?
    
    // ViewModel
    private var viewModel: ListViewModel!
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigationItem = navigationItem as? ListRootNavigationItem else {
            return
        }
        
        observeViewModel()
        
        navigationItem.inject(viewModel: viewModel)
        rootView.inject(viewModel: viewModel)
    }
}

// MARK: - Bindings
private extension ListTableViewController {
    
    private func observeViewModel() {
        
        let observable = viewModel.view.distinctUntilChanged()
        subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<ListView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState(view)
        }).disposed(by: disposeBag)
    }
}

// MARK: - UI
private extension ListTableViewController {
    
    func updateViewState(_ view: ListView) {
        switch view {
        case .loading:
            showLoadingView()
        case .failure(let error):
            showErrorView(for: error)
        case .showingData:
            clearLoadingIndicator()
            clearBackgroundView()
        case .deleting:
            showLoadingIndicator()
        }
    }
    
    func showLoadingView() {
        tableView.backgroundView = ListRootLoadingView()
    }
    
    func showErrorView(for error: ErrorMessage) {
        tableView.backgroundView = ListRootErrorView(error: error)
    }
    
    func showLoadingIndicator() {
        let alertController = UIAlertController(title: "Loading", message: nil, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        self.alertController = alertController
    }
    
    func clearLoadingIndicator() {
        alertController?.dismiss(animated: true, completion: nil)
    }
    
    func clearBackgroundView() {
        tableView.backgroundView = nil
    }
}
