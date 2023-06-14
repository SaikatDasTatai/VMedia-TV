//
//  TVGuideCoordinator.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 14/06/23.
//

import UIKit

class TVGuideCoordinator: Coordinator {
    var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let viewController = TVGuideViewController()
        presenter.pushViewController(viewController, animated: true)
    }
}
