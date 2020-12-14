//
//  AddNavigationController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import TFCommonKit
import RxSwift

public class AddNavigationController: UINavigationController {
    
    // MARK: - Properties
    // ViewModel
    private let viewModel: AddNavigationViewModel
    
    // ViewControllers
    private let addViewController: AddViewController
    
    // Storage
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModel: AddNavigationViewModel,
         addViewController: AddViewController) {
        self.viewModel = viewModel
        self.addViewController = addViewController
        
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

extension AddNavigationController {
    
    private func observeViewModel() {
        let observable = viewModel.navigationAction.distinctUntilChanged()
      subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<AddNavigationAction>) {
        observable.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.respond(to: action)
        }).disposed(by: disposeBag)
    }
    
    func respond(to action: AddNavigationAction) {
        switch action {
        case .present(let view):
            present(view)
        case .presented:
            break
        }
    }
}

extension AddNavigationController {
    
    func present(_ view: AddNavigationView) {
        switch view {
        case .form:
            presentAddViewController()
        }
    }
    
    func presentAddViewController() {
        pushViewController(addViewController, animated: false)
    }
}

extension AddNavigationController {
    func hideOrShowNavigationBarIfNeeded(for view: AddNavigationView, animated: Bool) {
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

extension AddNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let viewThatWillShow = addNavigationView(associatedWith: viewController) else {return}
        hideOrShowNavigationBarIfNeeded(for: viewThatWillShow, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewThatDidShow = addNavigationView(associatedWith: viewController) else {return}
        viewModel.uiPresented(addNavigationView: viewThatDidShow)
    }
}

private extension AddNavigationController {
    func addNavigationView(associatedWith viewController: UIViewController) -> AddNavigationView? {
      switch viewController {
      case is AddViewController:
        return .form
      default:
        assertionFailure("Encountered unexpected child view controller type in \(self)")
        return nil
      }
    }
}
