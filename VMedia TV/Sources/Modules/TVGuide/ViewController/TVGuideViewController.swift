//
//  TVGuideViewController.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import Combine
import UIKit

// TODO: Will have one delegate pattern to inform Coordinator
// TODO: When Scroll is at end we can call delegate to get more Data
class TVGuideViewController: BaseViewController {
    struct Model {
        var tvGuideMainViewModel: TVGuideMainView.Model?
    }
    /// Represents store for publishers
    private var store: Set<AnyCancellable> = []
    /// Represents view controller's view model
    private let modelPublisher: CurrentValueSubject<Model?, Never>
    private lazy var mainView = TVGuideMainView()
    
    /// Initialises Base view controller with viewModel
    init(modelPublisher: CurrentValueSubject<Model?, Never>) {
        self.modelPublisher = modelPublisher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        modelPublisher.sink { [self] model in
            applyModel(model: model)
        }.store(in: &store)
    }
    
    override func constructView() {
        super.constructView()
        
        // Style background view
        mainView.backgroundColor = .clear
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        
        view.addAutoLayoutSubview(mainView)
    }
    
    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()

        // Add constraints to view
        NSLayoutConstraint.activate(
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        )
    }
}

extension TVGuideViewController {
    func applyModel(model: Model?) {
        guard let model = model else { return }
        
        mainView.model = model.tvGuideMainViewModel
        setupAccessibility()
    }
    
    // TODO: Write the accessibility code eg `Voice over`
    // JIRA: Jira_link
    func setupAccessibility() {}
}
