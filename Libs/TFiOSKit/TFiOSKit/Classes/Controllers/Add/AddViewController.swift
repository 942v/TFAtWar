//
//  AddViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import TFCommonKit

public class AddViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: AddViewModel!
    
    // MARK: - Injection of dependencies
    public func inject(viewModelFactory: AddViewModelFactory) {
        self.viewModel = viewModelFactory.makeAddViewModel()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
