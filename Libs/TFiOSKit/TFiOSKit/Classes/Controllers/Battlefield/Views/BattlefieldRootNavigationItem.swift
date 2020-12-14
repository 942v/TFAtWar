//
//  BattlefieldRootNavigationItem.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import TFCommonKit

class BattlefieldRootNavigationItem: UINavigationItem {
    
    // MARK: - Properties
    @IBOutlet weak var goBackBarButton: UIBarButtonItem!
    @IBOutlet weak var startBarButton: UIBarButtonItem!
    
    // ViewModel
    private unowned var viewModel: BattlefieldViewModel!
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: BattlefieldViewModel) {
        self.viewModel = viewModel
        
        setup()
    }

    private func setup() {
        title = viewModel.title()
    }
}

// MARK: - Actions
extension BattlefieldRootNavigationItem {
    
    @IBAction func doEndAction(_ sender: Any) {
        viewModel.cancel()
    }
    
    @IBAction func doStartAction(_ sender: Any) {
        viewModel.startMatch()
    }
}
