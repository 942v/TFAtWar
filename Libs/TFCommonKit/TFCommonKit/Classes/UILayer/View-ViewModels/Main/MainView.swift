//
//  MainView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum MainView {
    case mainNavigationController
    case battlefield
}

extension MainView: Equatable {
    
    public static func ==(lhs: MainView, rhs: MainView) -> Bool {
        switch (lhs, rhs) {
        case (.mainNavigationController, .mainNavigationController),
             (.battlefield, .battlefield):
            return true
        case (.mainNavigationController, _),
             (.battlefield, _):
            return false
        }
    }
}
