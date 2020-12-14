//
//  AddRootTableViewTextFieldCell.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import TFCommonKit
import RxSwift
import RxCocoa

protocol AddRootTableViewCellFormInput {
    var addFormItem: AddFormItem? { get set }
    
    func configure()
    func update(with addFormItem: AddFormItem)
}

class AddRootTableViewTextFieldCell: UITableViewCell, AddRootTableViewCellFormInput {
    
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private var didConfigure = false
    
    // State
    private let disposeBag = DisposeBag()
    
    // MARK: - AddRootTableViewCellFormInput
    var addFormItem: AddFormItem?
    
    func configure() {
        guard didConfigure == false else {
            return
        }
        bindTextField()
        didConfigure = true
    }
    
    func update(with addFormItem: AddFormItem) {
        
        self.addFormItem = addFormItem
        
        self.titleLabel.text = addFormItem.title
        
        self.textField.placeholder = addFormItem.placeholder
        self.textField.keyboardType = addFormItem.properties.keyboardType
        self.textField.text = addFormItem.value
        
        let fillColor: UIColor = addFormItem.isValid == false ? .red : .white
        self.backgroundColor = fillColor
    }
}

// MARK: - Bindings
extension AddRootTableViewTextFieldCell {
    
    func bindTextField() {
        textField.rx.text
            .observeOn(MainScheduler.asyncInstance)
            .map { $0! }
            .subscribe {
                self.addFormItem?.onCompletion?($0.element)
            }.disposed(by: disposeBag)
    }
}

