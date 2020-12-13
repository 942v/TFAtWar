//
//  AddViewModel.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import RxSwift
import TFData

public class AddViewModel {
    
    // MARK: - Properties
    private unowned let transformerDataRepository: TransformersDataRepositoryProtocol
    private let transformer: TransformerData?
    
    // MARK: State
    private let viewSubject = BehaviorSubject<AddView>(value: .idle)
    public var view: Observable<AddView> {
        return viewSubject.asObservable()
    }
    
    // MARK: - Init
    public init(transformerDataRepository: TransformersDataRepositoryProtocol,
                transformer: TransformerData?) {
        self.transformerDataRepository = transformerDataRepository
        self.transformer = transformer
    }
}
