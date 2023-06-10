//
//  TVGuideMainView.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class TVGuideMainView: BaseView {
    /// represents collection view data source
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>

    /// represents collection view snapshot
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    /// represents data source for collection view
    lazy var dataSource: DataSource = {
        let dataSource = constructDataSource()
        return dataSource
    }()

    /// represents generic layout
    private lazy var customLayout = CompositionLayout(dataSource: dataSource)

    /// represents vertical scrolling collection View
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CompositionLayout() // Default `init`
    )
    
    override func constructView() {
        super.constructView()

        // Style collection view
        apply(collectionView) { [weak self] in
            $0.bounces = false
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false

            // Custom layout for collection view
            guard let self else { return }
            $0.collectionViewLayout = self.customLayout
        }

        // Style data source
        apply(dataSource) { [weak self] in
            $0.supplementaryViewProvider = self?.constructSupplementaryViewProvider()
        }
    }

    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        // Add collection view to view sub-hierarchy
        addAutoLayoutSubview(collectionView)
    }

    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()

        // Add constraints to collection view
        NSLayoutConstraint.activate(
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        )
    }
}

// MARK: - Collection view data source

extension TVGuideMainView {
    /// - Section header or footer view
    /// - returns header or footer view
    func constructSupplementaryViewProvider() -> UICollectionViewDiffableDataSource.SupplementaryViewProvider {
        { _ , kind, indexPath in
            guard let view = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
            ) as? HeaderView
            else {
                fatalError("could not dequeue reusable supplementaryView view of type: \(HeaderView.self)")
            }
            return view
        }
    }

    /// - Construct data source for collection view
    /// - returns DataSource
    func constructDataSource() -> DataSource {
        .init(
            collectionView: collectionView
        ) { [weak self] _, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            
            // create cells for collection view
            switch itemIdentifier {
            case .program(let model):
                return self.program(from: indexPath, model: model)
            }
        }
    }
}

extension TVGuideMainView {
    /// - Collection view generic `program` cell
    /// - Parameters:
    ///  - indexPath: represents indexPath of collection view.
    ///  - model: represents model for program cell.
    func program(from indexPath: IndexPath, model: ProgramView.Model) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "program", for: indexPath) as? ProgramViewCell
        cell?.model = model
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Model

extension TVGuideMainView {
    /// - Model
    /// - Parameters:
    ///  - items: represents array of section and rows
    struct Model: Equatable, Hashable {
        var items: [Items]
    }

    /// - Items
    /// - Parameters:
    ///  - header: represents section in collection view
    ///  - rows: represents  rows for particular section in collection view
    struct Items: Equatable, Hashable {
        var section: Section?
        var rows: [Row]
    }

    /// - Section
    /// - Parameters:
    ///  - title: represents section title view for collection view
    enum Section: Equatable, Hashable {
        case header(HeaderView.Model)
    }

    /// - Row
    /// - Parameters:
    ///  - guide: represents guide cell with view `GuideView`
    enum Row: Equatable, Hashable {
        case program(ProgramView.Model)
    }
}
