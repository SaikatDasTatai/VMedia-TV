//
//  HeaderView.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class HeaderView: BaseCollectionReusableView {
    var model: Model? {
        didSet {
            guard let model else { return }
            
            applyModel(model: model)
        }
    }
    private let titleLabel = UILabel()
    override func constructView() {
        super.constructView()
        
        backgroundColor = .white
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        
        // Add collection view to view sub-hierarchy
        addAutoLayoutSubview(titleLabel)
    }
    
    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()
        // Add constraints
        NSLayoutConstraint.activate(
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        )
    }
    
    func applyModel(model: Model) {
        titleLabel.text = model.channel
    }
}

// MARK: - Model

extension HeaderView {
    /// - Model
    /// - Parameters:
    ///  -
    struct Model: Equatable, Hashable {
        var channel: String?
    }
}
