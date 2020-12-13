//
//  AddViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import TFCommonKit
import TFData

public class AddViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: AddViewModel!
    
    // MARK: - Injection of dependencies
    public func inject(viewModel: AddViewModel) {
        self.viewModel = viewModel
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
