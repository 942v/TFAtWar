//
//  BattlefieldResponder.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import Foundation

public protocol BattlefieldResponder: AnyObject {
    
    func transformersForBattle() -> [TransformerData]
}
