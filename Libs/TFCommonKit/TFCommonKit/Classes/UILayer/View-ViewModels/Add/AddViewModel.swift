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
    private let didFinishAddResponder: DidFinishAddResponder
    private let transformer: TransformerData?
    
    // MARK: State
    private let viewSubject = BehaviorSubject<AddView>(value: .idle)
    public let barButtonsEnabled = BehaviorSubject<Bool>(value: true)
    public var view: Observable<AddView> {
        return viewSubject.asObservable()
    }
    
    // MARK: - Init
    public init(transformerDataRepository: TransformersDataRepositoryProtocol,
                didFinishAddResponder: DidFinishAddResponder,
                transformer: TransformerData?) {
        self.transformerDataRepository = transformerDataRepository
        self.didFinishAddResponder = didFinishAddResponder
        self.transformer = transformer
    }
}

// MARK: - Actions
extension AddViewModel {
    public func title() -> String {
        return "Add a transformer"
    }
    
    public func cancel() {
        didFinishAddResponder.didCancelAdd()
    }
    
    public func save() {
        viewSubject.onNext(.validating)
    }
    
    public func sendTransformer(transformerRequest: TransformerRequest) {
        if transformerRequest.id != nil {
            updateTransformer(transformerRequest: transformerRequest)
        }else{
            createTransformer(transformerRequest: transformerRequest)
        }
    }
    
    public func errorInValidation() {
        viewSubject.onNext(.idle)
    }
}

extension AddViewModel {
    
    private func createTransformer(transformerRequest: TransformerRequest) {
        viewSubject.onNext(.loading)
        barButtonsEnabled.onNext(false)
        transformerDataRepository.create(transformerRequest)
            .done { [weak self] _ in
                self?.onDone()
            }
            .catch { [weak self] error in
                self?.onError(error)
            }
    }
    
    private func updateTransformer(transformerRequest: TransformerRequest) {
        viewSubject.onNext(.loading)
        transformerDataRepository.change(transformerRequest)
            .done { [weak self] _ in
                self?.onDone()
            }
            .catch { [weak self] error in
                self?.onError(error)
            }
    }
    
    private func onDone() {
        self.viewSubject.onNext(.idle)
        self.didFinishAddResponder.didAddData()
        self.barButtonsEnabled.onNext(true)
    }
    
    private func onError(_ error: Error) {
        let errorMessage = ErrorMessage.init(title: "Error!", message: error.localizedDescription)
        self.viewSubject.onNext(.failure(error: errorMessage))
        self.viewSubject.onNext(.idle)
        self.barButtonsEnabled.onNext(true)
    }
}
