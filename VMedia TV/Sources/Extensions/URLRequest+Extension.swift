//
//  URLRequest+Extension.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 15/06/23.
//

import Foundation

extension URLRequest {
    static var channelsAPI: Self {
        .init(url: URL(string: URLPath.baseURL + URLPath.channels)!)
    }
    
    static var programsAPI: Self {
        .init(url: URL(string: URLPath.baseURL + URLPath.programItems)!)
    }
}

extension URLRequest {
    enum URLPath {
        static let baseURL = "https://demo-c.cdn.vmedia.ca/json/"
        static let channels = "Channels"
        static let programItems = "ProgramItems"
    }
}
