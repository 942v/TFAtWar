//
//  BattlefieldResponder.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import Foundation
import TFData

public protocol BattlefieldResponder: AnyObject {
    
    func transformersForBattle() -> [TransformerData]
}
