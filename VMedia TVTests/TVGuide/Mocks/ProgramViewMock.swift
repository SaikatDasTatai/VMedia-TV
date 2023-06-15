//
//  ProgramViewMock.swift
//  VMedia TVTests
//
//  Created by Sd Saikat Das on 15/06/23.
//

@testable
import VMedia_TV
import UIKit

extension ProgramView.Model {
    static var mock: Self {
        .init(programName: Text.programName, broadCastTime: Text.time)
    }

    /// Texts
    enum Text {
        static let programName = "Newsy Tonight"
        static let time = "jul 9, 2020 11:34 PM"
    }
}
