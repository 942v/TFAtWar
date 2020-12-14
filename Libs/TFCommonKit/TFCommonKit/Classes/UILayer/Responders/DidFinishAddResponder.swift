//
//  DidFinishAddResponder.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit

public protocol DidFinishAddResponder: AnyObject {
    
    func didAddData()
    func didCancelAdd()
}
