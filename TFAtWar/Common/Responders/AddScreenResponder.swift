//
//  AddScreenResponder.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public protocol AddScreenResponder: AnyObject {
    
    func showAddScreen(transformer: TransformerData?)
    func removeAddScreen()
}
