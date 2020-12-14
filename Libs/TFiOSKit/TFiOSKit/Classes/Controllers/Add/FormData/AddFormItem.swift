//
//  AddFormItem.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import Foundation

class AddFormItem: AddFormItemValidator {
    
    // MARK: - Properties
    var value: String?
    var title: String
    var placeholder = ""
    var indexPath: IndexPath?
    var onCompletion: OnFormItemCompletion?
    var properties = AddFormItemProperties()
    
    // MARK: - Init
    init(title: String,
         value: String? = nil,
         placeholder: String) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
    // MARK: - FormItemValidator
    var isValid = true
    
    func checkIfValid() {
        isValid = (value != nil) && (value?.isEmpty == false)
    }
}
