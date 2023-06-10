//
//  UICollectionView+Extension.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

extension UICollectionView {
    /// Convenience method to register a cell of a particular type
    /// - Parameter type: type of the cell
    public func registerCell<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    /// Convenience method to register a view of a particular type
    /// - Parameters:
    ///   - type: type of the view
    ///   - kind: kind of supplementary view to create. for example `UICollectionView.elementKindSectionHeader`
    public func register<View: UICollectionReusableView>(
        _ type: View.Type,
        ofKind kind: String
    ) {
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
    }
}
