//
//  ListRootErrorView.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit
import PATools
import TFData

class ListRootErrorView: NiblessView {
    private var hierarchyNotReady = true
    
    private let error: Error
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [
            centerLabel,
            activityIndicator
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.text = "Error: \(error.localizedDescription)"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    // MARK: Methods
    public init(frame: CGRect = .zero,
                error: ErrorMessage) {
        self.error = error
        super.init(frame: frame)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        constructHierarchy()
        activateConstraints()
        
        hierarchyNotReady = false
    }
    
    func constructHierarchy() {
        addSubview(mainStackView)
    }
    
    func activateConstraints() {
        activateConstraintsMainStackView()
    }
}

// MARK: Layout
extension ListRootErrorView {
    
    func activateConstraintsMainStackView() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerY = mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
    }
}
