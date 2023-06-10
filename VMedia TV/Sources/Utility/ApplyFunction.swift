//
//  ApplyFunction.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import Foundation

/// - Apply function
/// - Parameters:
///  - elements: represents veridic generic item.
///  - closure: represents closure for custom code.
func apply<T>(_ elements: T..., closure: (T) -> Void) {
    for element in elements {
        closure(element)
    }
}
