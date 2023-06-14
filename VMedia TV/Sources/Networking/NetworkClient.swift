//
//  NetworkClient.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 14/06/23.
//

import Foundation

protocol NetworkClient {
    func fetch<Response: Decodable>(urlRequest: URLRequest) async -> Result<Response, NetworkError>
}

extension OrchestrationClient: NetworkClient {
    func fetch<Response: Decodable>(urlRequest: URLRequest) async -> Result<Response, NetworkError> {
        do {
            let value = try await networking.data(for: urlRequest)
            let decoder = JSONDecoder()
            return .success(try decoder.decode(Response.self, from: value.0))
        } catch {
            return .failure(.httpError)
        }
    }
}

enum NetworkError: Error {
    case httpError
}
