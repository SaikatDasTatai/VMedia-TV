//
//  ViewConstructable.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import Foundation

/// This protocol defines the phases of view construction.
///
/// When conforming to this protocol, implement the construction phaeses and call `construct()` as soon as the primary
/// view is available.
public protocol ViewConstructable: AnyObject {
    /// Provides a call to inform the conforming object that the view is about to begin construction
    ///
    /// **Do not call this method directly.** Conforming types should trigger this method by calling `construct()`.
    func viewWillConstruct()

    /// Provides a call to inform the conforming object that the view has finished construction
    ///
    /// **Do not call this method directly.** Conforming types should trigger this method by calling `construct()`.
    func viewDidConstruct()

    /// Configures the primary view
    ///
    /// **Do not call this method directly.** Conforming types should trigger this method by calling `construct()`.
    func constructView()

    /// Assembles subviews into the correct hierarchy
    ///
    /// **Do not call this method directly.** Conforming types should trigger this method by calling `construct()`.
    func constructSubviewHierarchy()

    /// Adds layout constraints and sets layout-related properties
    ///
    /// **Do not call this method directly.** Conforming types should trigger this method by calling `construct()`.
    func constructSubviewLayoutConstraints()
}

// MARK: - Construction

extension ViewConstructable {
    public func construct() {
        viewWillConstruct()
        constructView()
        constructSubviewHierarchy()
        constructSubviewLayoutConstraints()
        viewDidConstruct()
    }

    // Note: Do not add default implementations of the `constructX()` methods. Default implementations are not
    // compatible with subclassing.
}
