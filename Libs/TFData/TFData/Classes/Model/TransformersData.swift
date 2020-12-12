//
//  TransformersData.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation

public struct TransformersData {
    let transformers: [TransformerData]
}

extension TransformersData: Decodable { }
