//
//  ListVIewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import RxSwift
import TFData

public class ListViewModel {
    
    // MARK: - Properties
    private unowned let transformerDataRepository: TransformersDataRepositoryProtocol
    
    // MARK: State
    private let viewSubject = BehaviorSubject<ListView>(value: .loading)
    public var view: Observable<ListView> {
        return viewSubject.asObservable()
    }
    
    // MARK: - Init
    public init(transformerDataRepository: TransformersDataRepositoryProtocol) {
        self.transformerDataRepository = transformerDataRepository
    }
}
