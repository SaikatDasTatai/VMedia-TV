//
//  UIView+Extension.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

extension UIView {
    /// A convenience method for adding a subview and setting `translatesAutoresizingMaskIntoConstraints` to `false` at
    /// Use this wherever you would normally use `addSubview()`
    ///
    public func addAutoLayoutSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
    
    /// A convenience method for adding a subview and setting `translatesAutoresizingMaskIntoConstraints` to `false` at Use this wherever you would normally use `addSubview()`
    /// the same time.
    ///
    public func addAutoLayoutSubviews(_ subviews: UIView...) {
        subviews.forEach { addAutoLayoutSubview($0) }
    }
}
