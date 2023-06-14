//
//  ProgramView.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class ProgramView: BaseView {
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
        titleLabel.text = model.programName
    }
}

// MARK: - Model

extension ProgramView {
    /// - Model
    /// - Parameters:
    ///  -
    struct Model: Equatable, Hashable {
        let id = UUID()
        var programName: String?
    }
}

class ProgramViewCell: BaseCollectionViewCell {
    lazy var view = ProgramView()

    var model: ProgramView.Model? {
        didSet {
            view.model = model
        }
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        // Add view to contentView hierarchy.
        contentView.addAutoLayoutSubview(view)
    }

    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()
        // Add constraints to collection view Cell
        NSLayoutConstraint.activate(
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
}
