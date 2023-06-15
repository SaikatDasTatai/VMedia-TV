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
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    override func constructView() {
        super.constructView()
        
        backgroundColor = .white
        roundCorners(corners: .allCorners, radius: Spacing.space8)
        applyDropShadowStyle(withOffset: .zero, opacity: 0.15, radius: 2, color: .black)
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        
        // Add collection view to view sub-hierarchy
        addAutoLayoutSubviews(titleLabel, subTitleLabel)
    }
    
    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()
        // Add constraints
        NSLayoutConstraint.activate(
            // Title
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Spacing.space4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.space4),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.space4),
            
            // Subtitle
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Spacing.space4),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.space4),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -Spacing.space4),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Spacing.space4)
        )
    }
    
    func applyModel(model: Model) {
        titleLabel.text = model.programName
        subTitleLabel.text = model.broadCastTime
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
        var broadCastTime: String?
    }
}
/// To show the potential of unit test
/// How to test private fields
/// For the sake of time only implementing for this View
/// THough best practice is to cover more than `90%` for Each `PR` we raise
#if DEBUG
extension ProgramView {
    var testHooks: TestHooks { .init(target: self) }
    
    struct TestHooks {
        let target: ProgramView
        
        var title: String? {
            target.titleLabel.text
        }
        
        var subTitle: String? {
            target.subTitleLabel.text
        }
    }
}
#endif
