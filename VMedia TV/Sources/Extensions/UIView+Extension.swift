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

extension UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UIView {
    /// The perfect way to round corners for a UIView. After invoking this method, the corners of your view will
    public func roundCorners(corners: UIRectCorner = .allCorners, radius: CGFloat = 38.5) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    /// Applies the drop shadow style for a view
    public func applyDropShadowStyle(withOffset offset: CGSize, opacity: Float, radius: CGFloat, color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
