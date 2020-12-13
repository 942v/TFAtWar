//
//  ShowAddScreenResponder.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import TFData

public protocol ShowAddScreenResponder: AnyObject {
    
    func showAddScreen(transformer: TransformerData?)
}
