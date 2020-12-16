//
//  AddViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import RxSwift

public class AddViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var rootView: AddRootTableView!
    private weak var loadingView: UIView?
    
    // ViewModel
    private var viewModel: AddViewModel!
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: AddViewModel) {
        self.viewModel = viewModel
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigationItem = navigationItem as? AddRootNavigationItem else {
            return
        }
        
        observeViewModel()
        
        navigationItem.inject(viewModel: viewModel)
        rootView.inject(viewModel: viewModel)
    }
}

// MARK: - Bindings
private extension AddViewController {
    
    private func observeViewModel() {
        
        let observable = viewModel.view.distinctUntilChanged()
        subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<AddView>) {
        observable.subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.updateViewState(view)
        }).disposed(by: disposeBag)
    }
}

// MARK: - UI
private extension AddViewController {
    
    func updateViewState(_ view: AddView) {
        switch view {
        case .loading:
            showLoadingIndicator()
        case .failure(let error):
            showErrorView(for: error)
        case .idle:
            clearLoadingIndicator()
        default:
            return
        }
    }
    
    func showLoadingIndicator() {
        let loadingView = UIView()
        loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        let constraints = [
            view.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor),
            view.topAnchor.constraint(equalTo: loadingView.topAnchor),
            view.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor)
        ]
        constraints.forEach { $0.isActive = true }
        view.addConstraints(constraints)
        
        self.loadingView = loadingView
    }
    
    func showErrorView(for error: ErrorMessage) {
        let alertController = UIAlertController.errorAlert(title: error.title, message: error.message)
        present(alertController, animated: true, completion: nil)
    }
    
    func clearLoadingIndicator() {
        self.loadingView?.removeFromSuperview()
    }
}
