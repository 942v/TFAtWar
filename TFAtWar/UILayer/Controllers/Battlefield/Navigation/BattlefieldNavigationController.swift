//
//  BattlefieldNavigationController.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import RxSwift

public class BattlefieldNavigationController: UINavigationController {
    
    // MARK: - Properties
    // ViewModel
    private let viewModel: BattlefieldNavigationViewModel
    
    // ViewControllers
    private let battlefieldViewController: BattlefieldViewController
    
    // Storage
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModel: BattlefieldNavigationViewModel,
         battlefieldViewController: BattlefieldViewController) {
        self.viewModel = viewModel
        self.battlefieldViewController = battlefieldViewController
        
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

extension BattlefieldNavigationController {
    
    private func observeViewModel() {
        let observable = viewModel.navigationAction.distinctUntilChanged()
      subscribe(to: observable)
    }
    
    func subscribe(to observable: Observable<BattlefieldNavigationAction>) {
        observable.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.respond(to: action)
        }).disposed(by: disposeBag)
    }
    
    func respond(to action: BattlefieldNavigationAction) {
        switch action {
        case .present(let view):
            present(view)
        case .presented:
            break
        }
    }
}

extension BattlefieldNavigationController {
    
    func present(_ view: BattlefieldNavigationView) {
        switch view {
        case .battlefield:
            presentBattlefieldViewController()
        }
    }
    
    func presentBattlefieldViewController() {
        pushViewController(battlefieldViewController, animated: false)
    }
}

extension BattlefieldNavigationController {
    func hideOrShowNavigationBarIfNeeded(for view: BattlefieldNavigationView, animated: Bool) {
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

extension BattlefieldNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let viewThatWillShow = battlefieldNavigationView(associatedWith: viewController) else {return}
        hideOrShowNavigationBarIfNeeded(for: viewThatWillShow, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewThatDidShow = battlefieldNavigationView(associatedWith: viewController) else {return}
        viewModel.uiPresented(battlefieldNavigationView: viewThatDidShow)
    }
}

private extension BattlefieldNavigationController {
    func battlefieldNavigationView(associatedWith viewController: UIViewController) -> BattlefieldNavigationView? {
      switch viewController {
      case is BattlefieldViewController:
        return .battlefield
      default:
        assertionFailure("Encountered unexpected child view controller type in \(self)")
        return nil
      }
    }
}
