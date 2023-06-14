//
//  TVGuideDataSource.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 14/06/23.
//

import Foundation

// MARK: - TVGuideDataSourceAPI

/// - TVGuideDataSourceAPI
/// - Protocol for TVGuideDataSource
/// - Parameters:
///  - fetchDetails(): function to fetch details
protocol TVGuideDataSourceAPI {
    init(networkClient: NetworkClient)
    /// This method will internally communicate with Network APIs
    func fetchDetails<Response: Decodable>(urlRequest: URLRequest) async
    -> Result<Response, NetworkError>
}

/// - TVGuideDataSource
/// - Data source for TVGuide
/// - Parameters:
///  - service: represents network client
final class TVGuideDataSource {
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - HubDataSourceAPI

extension TVGuideDataSource: TVGuideDataSourceAPI {
    /// Fetch TVGuide Data
    func fetchDetails<Response: Decodable>(urlRequest: URLRequest) async
    -> Result<Response, NetworkError> {
        return await networkClient.fetch(urlRequest: urlRequest)
    }
}
