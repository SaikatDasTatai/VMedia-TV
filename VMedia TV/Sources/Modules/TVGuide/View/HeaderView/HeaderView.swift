//
//  HeaderView.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class HeaderView: UICollectionReusableView {
//    var model: Model? {
//        didSet {
//            guard let model else { return }
//
//            applyModel(model: model)
//        }
//    }
//    private let titleLabel = UILabel()
//    override func constructView() {
//        super.constructView()
//
//        backgroundColor = .white
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func constructSubviewHierarchy() {
//        super.constructSubviewHierarchy()
//
//        // Add collection view to view sub-hierarchy
//        //addAutoLayoutSubview(titleLabel)
//    }
    
//    override func constructSubviewLayoutConstraints() {
//        super.constructSubviewLayoutConstraints()
//        // Add constraints
////        NSLayoutConstraint.activate(
////            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
////            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
////            titleLabel.topAnchor.constraint(equalTo: topAnchor),
////            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
////        )
//    }
//    
//    func applyModel(model: Model) {
//        titleLabel.text = model.channel
//    }
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
        NSLayoutConstraint.activate(
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        )
    }
}
