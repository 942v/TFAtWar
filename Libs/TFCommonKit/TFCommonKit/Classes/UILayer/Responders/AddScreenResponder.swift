//
//  AddScreenResponder.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import TFData

public protocol AddScreenResponder: AnyObject {
    
    func showAddScreen(transformer: TransformerData?)
    func removeAddScreen()
}
