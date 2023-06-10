//
//  TVGuideViewController.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class TVGuideViewController: BaseViewController {
    private lazy var mainView = TVGuideMainView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func constructView() {
        super.constructView()
        
        // Style background view
        mainView.backgroundColor = .red
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
    }
    
    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()

        // Add constraints to background view
        NSLayoutConstraint.activate([
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

