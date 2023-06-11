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
            $0.backgroundColor = .blue
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.registerCell(ProgramViewCell.self)
            $0.register(
                HeaderView.self,
                ofKind: UICollectionView.elementKindSectionHeader
            )

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
        
        let model: Model = .mock
        
        var snapshot = Snapshot()
        snapshot.appendSections(model.items.compactMap { $0.section })
        model.items.forEach {
            snapshot.appendItems($0.rows, toSection: $0.section)
        }
        
        // NOTE: Validate sectionIdentifiers before applying snapshot
        if snapshot.sectionIdentifiers.isEmpty {
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
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
            view.model = .init(channel: "Fox" + (1...10000).randomElement()!.description)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgramViewCell.self), for: indexPath) as? ProgramViewCell
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

extension TVGuideMainView.Model {
    static var mock: Self {
        .init(
            items: [
                .init(
                    section: .header(.init()),
                    rows: [
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga3")),
                        .program(.init(programName: "La Liga4")),
                        .program(.init(programName: "La Liga5")),
                        .program(.init(programName: "La Liga6")),
                        .program(.init(programName: "La Liga7")),
                        .program(.init(programName: "La Liga8")),
                        .program(.init(programName: "La Liga9")),
                        .program(.init(programName: "La Liga10")),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description)),
                        .program(.init(programName: "La Liga1" + (1...10000).randomElement()!.description))
                    ]
                )
            ]
        )
    }
}
