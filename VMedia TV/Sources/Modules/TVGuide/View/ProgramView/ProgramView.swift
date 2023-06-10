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
        }
    }
    override func constructView() {
        super.constructView()
        
        backgroundColor = .red
    }
}

// MARK: - Model

extension ProgramView {
    /// - Model
    /// - Parameters:
    ///  -
    struct Model: Equatable, Hashable {
        
    }
}

class ProgramViewCell: UICollectionViewCell {
    lazy var view: ProgramView = .init()
    var model: ProgramView.Model? {
        didSet {
            view.model = model
        }
    }
}
