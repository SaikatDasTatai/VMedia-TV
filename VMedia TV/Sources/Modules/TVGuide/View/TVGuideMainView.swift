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
        collectionViewLayout: CompositionLayout()
    )
    
    var model: Model? {
        didSet {
            applyModel()
        }
    }
    
    
    
    override func constructView() {
        super.constructView()

        // Style collection view
        apply(collectionView) { [weak self] in
            $0.bounces = false
            $0.backgroundColor = .systemGroupedBackground
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
    }
}

extension TVGuideMainView {
    /// apply any logic when model is set
    func applyModel() {
        guard let model = model else { return }
        
        var snapshot = Snapshot()
        snapshot.appendSections(model.items.compactMap { $0.section })
        model.items.forEach {
            snapshot.appendItems($0.rows, toSection: $0.section)
        }
        
        // NOTE: Validate sectionIdentifiers before applying snapshot
        customLayout = CompositionLayout(noOfRows: CGFloat(model.headers.count))
        collectionView.collectionViewLayout = customLayout
        if snapshot.sectionIdentifiers.isEmpty {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Collection view data source

extension TVGuideMainView {
    /// - Section header or footer view
    /// - returns header or footer view
    func constructSupplementaryViewProvider() -> UICollectionViewDiffableDataSource.SupplementaryViewProvider {
        { [weak self] _ , kind, indexPath in
            guard let self = self, let view = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
            ) as? HeaderView
            else {
                fatalError("could not dequeue reusable supplementaryView view of type: \(HeaderView.self)")
            }
            let headers = self.model?.headers ?? []
            headers.forEach {
                let headerInnerView = HeaderInnerView(frame: $0.frame)
                headerInnerView.constructSubviewLayoutConstraints()
                headerInnerView.label.text = $0.model.channel
                view.addSubview(headerInnerView)
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
        var headers: [Header]
    }

    /// - Items
    /// - Parameters:
    ///  - header: represents section in collection view
    ///  - rows: represents  rows for particular section in collection view
    struct Items: Equatable, Hashable {
        var section: Section?
        var rows: [Row]
    }
    
    struct Header: Equatable, Hashable {
        var frame: CGRect
        var model: HeaderView.Model
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

extension CGRect: Hashable {
    /// Not a good algo, but it works for now in this limited time project
    public func hash(into hasher: inout Hasher) {
        hasher.combine((1...1000).randomElement().debugDescription)
    }
}
