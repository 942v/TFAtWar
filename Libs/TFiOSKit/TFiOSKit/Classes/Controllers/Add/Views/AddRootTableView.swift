//
//  AddRootTableView.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import Foundation
import TFCommonKit
import RxSwift

enum AddRootTableViewCellType: String {
    case textField = "TextFieldCell"
    case segmented = "SegmentedCell"
    
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: self.rawValue,
                                             for: indexPath)
        
        return cell
    }
}

class AddRootTableView: UITableView {
    
    // MARK: - Properties
    fileprivate var addFormData: AddFormData!
    
    // ViewModel
    private unowned var viewModel: AddViewModel!
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: AddViewModel) {
        self.viewModel = viewModel
        self.addFormData = AddFormData(from: viewModel.transformer)
        
        self.allowsSelection = false
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 36
        
        self.dataSource = self
        
        observeViewModel()
        
        self.reloadData()
    }
}

// MARK: - Actions
extension AddRootTableView {
    private func validateInputFields() -> Bool {
        let isValid = self.addFormData.isValid()
        self.reloadData()
        return isValid
    }
}

extension AddRootTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addFormData.formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = addFormData.formItems[indexPath.row]
        
        let cell: UITableViewCell
        if let cellType = item.properties.cellType {
            cell = cellType.dequeueCell(for: self, at: indexPath)
        }else{
            cell = UITableViewCell()
        }
        
        if let formInputCell = cell as? AddRootTableViewCellFormInput {
            item.indexPath = indexPath
            formInputCell.configure()
            formInputCell.update(with: item)
        }
        
        return cell
    }
}

// MARK: - Bindings
private extension AddRootTableView {
    
    private func observeViewModel() {
        
        let observable = viewModel.view.distinctUntilChanged()
        subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<AddView>) {
        observable
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] view in
            guard let strongSelf = self else { return }
            strongSelf.present(view)
        }).disposed(by: disposeBag)
    }
    
    func present(_ view: AddView) {
        switch view {
        case .validating:
            startValidating()
        default:
            return
        }
    }
    
    func startValidating() {
        let isValid = validateInputFields()
        if isValid {
            viewModel.sendTransformer(transformerRequest: addFormData.request)
        }else{
            viewModel.errorInValidation()
        }
    }
}
