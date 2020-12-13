//
//  ListTableView.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import RxSwift
import RxCocoa
import TFCommonKit
import TFData
import Kingfisher

fileprivate enum CellIdentifier: String {
    case cell
}

class ListRootTableView: UITableView {
    
    // MARK: - Properties
    
    // ViewModel
    private unowned var viewModel: ListViewModel!
    
    // State
    private var transformersResults = BehaviorSubject<[TransformerData]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: ListViewModel) {
        self.viewModel = viewModel
        
        self.rowHeight = UITableView.automaticDimension
        self.rowHeight = 158
        
        self.delegate = self
        self.dataSource = self
        
        observeViewModel()
        viewModel.loadData()
    }
}

// MARK: - UITableViewDataSource
extension ListRootTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try transformersResults.value().count
        } catch {
            fatalError("Error reading value")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        do {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell.rawValue) as? ListRootTableViewCell else {
                fatalError("Error casting cell to type")
            }
            
            let transformer = try transformersResults.value()[indexPath.row]
            cell.set(transformer)
            
            return cell
        } catch {
            fatalError("Error reading value")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.didDeleteTransformer(at: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate
extension ListRootTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Bindings
private extension ListRootTableView {
    
    private func observeViewModel() {
        
        viewModel.transformersResults
            .asDriver(onErrorRecover: { _ in fatalError("Fatal error in observable") })
            .drive(transformersResults)
            .disposed(by: disposeBag)
        
        transformersResults
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected view model search results observable error.") })
            .drive(onNext: { [weak self] _ in self?.reloadData() })
            .disposed(by: disposeBag)
    }
}
