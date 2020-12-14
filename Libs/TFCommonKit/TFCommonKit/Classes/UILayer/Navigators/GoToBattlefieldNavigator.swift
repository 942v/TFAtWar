//
//  GoToBattlefieldNavigator.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public protocol GoToBattlefieldNavigator: AnyObject {
    
    func navigateToBattlefield()
    func dismissBattlefield()
}
