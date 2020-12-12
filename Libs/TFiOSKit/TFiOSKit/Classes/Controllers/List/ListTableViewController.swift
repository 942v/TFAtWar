//
//  ListTableViewController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import TFCommonKit

public class ListTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var viewModel: ListViewModel!
    
    // MARK: - Inyection of properties
    public func inject(viewModelFactory: ListViewModelFactory) {
        self.viewModel = viewModelFactory.makeListViewModel()
    }
}
