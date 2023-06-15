//
//  ProgramViewCell.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 15/06/23.
//

import UIKit

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

