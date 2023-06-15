//
//  HeaderView.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

class HeaderInnerView: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constructSubviewLayoutConstraints() {
     
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        backgroundColor = .systemBlue
        roundCorners(corners: [.topRight, .bottomRight], radius: Spacing.space8)
        applyDropShadowStyle(withOffset: .zero, opacity: 0.15, radius: 2, color: .black)
        NSLayoutConstraint.activate(
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.space4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Spacing.space4),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.space4),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Spacing.space4)
        )
    }
}
