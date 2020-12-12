//
//  ListViewModelFactory.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import TFCommonKit

public protocol ListViewModelFactory {
  
  func makeListViewModel() -> ListViewModel
}
