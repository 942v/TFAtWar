//
//  NavigationAction.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
    case present(view: ViewModelType)
    case presented(view: ViewModelType)
}
