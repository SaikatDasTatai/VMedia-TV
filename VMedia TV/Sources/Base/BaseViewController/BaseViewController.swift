//
//  BaseViewController.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

/// A base class for `UIViewController`s using the Glass Platform.
///
/// The main feature of `BaseViewController` is conformance to `ViewConstructable`.
///
/// Subclasses that construct their own views should override the following methods (as needed):
///
/// - `constructView()`
/// - `constructSubviewHierarchy()`
/// - `constructSubviewLayoutConstraints()`
///
/// **Note:** Subclasses should be sure to call the superclass implementation when overriding these methods.
///

class BaseViewController: UIViewController, ViewConstructable {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        construct()
    }
    
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

    /// Configures the `view`
    ///
    /// Override this method to set properties of the `view`, attach event listeners, etc.
    ///
    /// **Do not call this method directly.** It is part of the `ViewConstructable` protocol, and is called
    /// automatically as part of `init(frame:)`
    open func constructView() {}

    /// Assembles subviews into the correct hierarchy
    ///
    /// Override this method to set add subviews, or subviews of subviews, etc.
    ///
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
