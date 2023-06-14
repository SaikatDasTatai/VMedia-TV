//
//  TVGuideCoordinator.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 14/06/23.
//

import Combine
import UIKit

protocol TVGuideCoordinatable: Coordinator {
    /// Starts coordinator
    func start()
}

class TVGuideCoordinator: Coordinator, TVGuideCoordinatable {
    private var presenter: UINavigationController
    /// Network client to interact with API
    private let networkClient: NetworkClient
    /// Helps in dependency injection
    private var tvGuideDataSourceType: TVGuideDataSourceAPI.Type = TVGuideDataSource.self
    /// Event publisher for the model changes
    fileprivate var eventPublisher = CurrentValueSubject<TVGuideViewController.Model?, Never>(nil)
    private var subscriptions = Set<AnyCancellable>()
    /// datasource to interact with Data source eg `http`, `GraphQL`, `DB` and `Cache`
    lazy var dataSource: TVGuideDataSourceAPI = tvGuideDataSourceType.init(networkClient: networkClient)
    
    init(presenter: UINavigationController, networkClient: NetworkClient) {
        self.presenter = presenter
        self.networkClient = networkClient
    }
    
    override func start() {
        /// Write the routing logic
        let viewController = TVGuideViewController(modelPublisher: eventPublisher)
        presenter.pushViewController(viewController, animated: true)
        
    }
}

extension TVGuideCoordinator {
    func loadTVGuide() {
        Task {
            let result: Result<ChannelModel, NetworkError> = await dataSource.fetchDetails(
                urlRequest: .channelsAPI
            )
            eventPublisher.value = .init(dataSource: result)
        }
    }
}
