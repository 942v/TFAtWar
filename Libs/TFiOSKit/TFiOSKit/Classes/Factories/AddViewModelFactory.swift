//
//  AddViewModelFactory.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import TFCommonKit
import TFData

public protocol AddViewModelFactory {
  
    func makeAddViewModel(transformer: TransformerData?) -> AddViewModel
}
