//
//  UICollectionReusableView.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

/// A base class for `UICollectionReusableView`s in Glass.
///
/// The main feature of `BaseCollectionReusableView` is conformance to `ViewConstructable`.
///
/// Subclasses should override the following methods (as needed) to construct themselves and their subviews:
///
/// - `constructView()`
/// - `constructSubviewHierarchy()`
/// - `constructSubviewLayoutConstraints()`
///
/// **Note:** Subclasses should be sure to call the superclass implementation when overriding these methods.
///
/// A secondary feature is that subclasses don't need to implement `init(coder:)`. `BaseCollectionReusableView` marks
/// that initializer as unavailable.
open class BaseCollectionReusableView: UICollectionReusableView, ViewConstructable {

    // MARK: Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)

        construct()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) is not supported") }

    // MARK: Construction

    /// Provides a call to inform the conforming object that the view is about to begin construction
    ///
    /// **Do not call this method directly.** It is part of the `ViewConstructable` protocol, and is called
    /// automatically as part of `init(frame:)`
    open func viewWillConstruct() {}

    /// Provides a call to inform the conforming object that the view has finished construction
    ///
    /// **Do not call this method directly.** It is part of the `ViewConstructable` protocol, and is called
    /// automatically as part of `init(frame:)`
    open func viewDidConstruct() {}

    /// Configures _this_ view
    ///
    /// Override this method to set properties of this view, attach event listeners to subviews, etc.
    ///
    /// **Do not call this method directly.** It is part of the `ViewConstructable` protocol, and is called
    /// automatically as part of `init(frame:)`
    open func constructView() {}

    /// Assembles subviews into the correct hierarchy
    ///
    /// Override this method to set add subviews, or subviews of subviews, etc.
    ///
    /// **Tip:** Use `addAutoLayoutSubview()` to add a subview and also set `translatesAutoresizingMaskIntoConstraints`
    /// to `false` on it.
    ///
    /// **Do not call this method directly.** It is part of the `ViewConstructable` protocol, and is called
    /// automatically as part of `init(frame:)`
    open func constructSubviewHierarchy() {}

    /// Adds layout constraints and sets layout-related properties
    ///
    /// **Do not call this method directly.** It is part of the `ViewConstructable` protocol, and is called
    /// automatically as part of `init(frame:)`
    open func constructSubviewLayoutConstraints() {}
}

