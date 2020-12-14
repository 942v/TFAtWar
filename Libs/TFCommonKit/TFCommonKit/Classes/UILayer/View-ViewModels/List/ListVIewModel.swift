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
    private unowned let battlefieldNavigator: GoToBattlefieldNavigator
    private unowned let addScreenResponder: AddScreenResponder
    
    // MARK: State
    private let viewSubject = BehaviorSubject<ListView>(value: .loading)
    public var view: Observable<ListView> {
        return viewSubject.asObservable()
    }
    
    public let transformersResults = BehaviorSubject<[TransformerData]>(value: [])
    
    // MARK: - Init
    public init(transformerDataRepository: TransformersDataRepositoryProtocol,
                battlefieldNavigator: GoToBattlefieldNavigator,
                addScreenResponder: AddScreenResponder) {
        self.transformerDataRepository = transformerDataRepository
        self.battlefieldNavigator = battlefieldNavigator
        self.addScreenResponder = addScreenResponder
    }
}

// MARK: - Actions
extension ListViewModel {
    
    public func title() -> String {
        return "Transformers"
    }
    
    public func loadData() {
        self.viewSubject.onNext(.loading)
        transformerDataRepository
            .getTransformers()
            .done { [weak self] fetchedTransformers in
                self?.update(fetchedTransformers: fetchedTransformers)
            }
            .catch { [weak self] error in
                let errorMessage = ErrorMessage.init(title: "Error!", message: error.localizedDescription)
                self?.showError(error: errorMessage)
            }
    }
    
    public func didDeleteTransformer(at indexPath: IndexPath) {
        self.viewSubject.onNext(.deleting)
        
        do {
            var values = try transformersResults.value()
            let transformer = values[indexPath.row]
            transformerDataRepository.delete(transformer.id)
                .done { [weak self] in
                    values.remove(at: indexPath.row)
                    self?.update(fetchedTransformers: values)
                }.catch{ [weak self] error in
                    let errorMessage = ErrorMessage.init(title: "Error!", message: error.localizedDescription)
                    self?.showError(error: errorMessage)
                }
        } catch {
            fatalError("Error reading value")
        }
    }
    
    public func showAddTransformer() {
        addScreenResponder.showAddScreen(transformer: nil)
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        do {
            let transformer = try transformersResults.value()[indexPath.row]
            addScreenResponder.showAddScreen(transformer: transformer)
        } catch {
            fatalError("Error reading value")
        }
    }
}

// MARK: -
private extension ListViewModel {
    
    private func update(fetchedTransformers: [TransformerData]) {
        self.viewSubject.onNext(.showingData)
        self.transformersResults.onNext(fetchedTransformers)
    }
    
    private func showError(error: ErrorMessage) {
        self.viewSubject.onNext(.failure(error: error))
    }
}

// MARK: - 
extension ListViewModel {
    public func showBattlefield() {
        battlefieldNavigator.navigateToBattlefield()
    }
}

// MARK: - DidFinishAddResponder
extension ListViewModel: DidFinishAddResponder {
    public func didAddData() {
        loadData()
        addScreenResponder.removeAddScreen()
    }

    public func didCancelAdd() {
        addScreenResponder.removeAddScreen()
    }
}
