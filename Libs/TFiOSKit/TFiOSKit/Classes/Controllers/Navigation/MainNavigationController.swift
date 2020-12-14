//
//  MainNavigationController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import TFData
import TFCommonKit
import RxSwift

public typealias AddNavigationControllerFactory = (TransformerData?) ->  AddNavigationController

public class MainNavigationController: UINavigationController {
    
    // MARK: - Properties
    // ViewModel
    private let viewModel: MainNavigationViewModel
    
    // ViewControllers
    private let listTableViewController: ListTableViewController
    
    // Factories
    private let makeAddNavigationController: AddNavigationControllerFactory
    
    // Storage
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModel: MainNavigationViewModel,
         listTableViewController: ListTableViewController,
         makeAddNavigationController: @escaping AddNavigationControllerFactory) {
        self.viewModel = viewModel
        self.listTableViewController = listTableViewController
        self.makeAddNavigationController = makeAddNavigationController
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
    }
}

extension MainNavigationController {
    
    private func observeViewModel() {
        let observable = viewModel.navigationAction.distinctUntilChanged()
        subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<MainNavigationAction>) {
        observable.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.respond(to: action)
        }).disposed(by: disposeBag)
    }
    
    func respond(to action: MainNavigationAction) {
        switch action {
        case .present(let view):
            present(view)
        case .presented:
            break
        }
    }
}

extension MainNavigationController {
    
    func present(_ view: MainNavigationView) {
        switch view {
        case .list:
            presentListTableViewController()
        case .add(let transformer):
            presentAddViewController(transformer)
        }
    }
    
    func presentListTableViewController() {
        guard self.viewControllers.first is ListTableViewController else {
            pushViewController(listTableViewController, animated: false)
            return
        }
        
        self.popToRootViewController(animated: true)
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func presentAddViewController(_ transformer: TransformerData?) {
        let addNavigationControllerToPresent = makeAddNavigationController(transformer)
        
        if #available(iOS 13.0, *) {
            addNavigationControllerToPresent.isModalInPresentation = true
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            addNavigationControllerToPresent.modalPresentationStyle = .formSheet
        }
        
        present(addNavigationControllerToPresent, animated: true, completion: nil)
    }
}

extension MainNavigationController {
    func hideOrShowNavigationBarIfNeeded(for view: MainNavigationView, animated: Bool) {
        if view.shouldHideNavigationBar() {
            hideNavigationBar(animated: animated)
        } else {
            showNavigationBar(animated: animated)
        }
    }
    
    func hideNavigationBar(animated: Bool) {
        if animated {
            transitionCoordinator?.animate(alongsideTransition: { context in
                self.setNavigationBarHidden(true, animated: animated)
            })
        } else {
            setNavigationBarHidden(true, animated: false)
        }
    }
    
    func showNavigationBar(animated: Bool) {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let viewThatWillShow = mainNavigationView(associatedWith: viewController) else {return}
        hideOrShowNavigationBarIfNeeded(for: viewThatWillShow, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewThatDidShow = mainNavigationView(associatedWith: viewController) else {return}
        viewModel.uiPresented(mainNavigationView: viewThatDidShow)
    }
}

private extension MainNavigationController {
    func mainNavigationView(associatedWith viewController: UIViewController) -> MainNavigationView? {
        switch viewController {
        case is ListTableViewController:
            return .list
        case is AddViewController:
            return .add(transformer: nil)
        default:
            assertionFailure("Encountered unexpected child view controller type in \(self)")
            return nil
        }
    }
}
