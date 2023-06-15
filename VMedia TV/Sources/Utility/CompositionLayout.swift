//
//  CompositionLayout.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class CompositionLayout: UICollectionViewCompositionalLayout {
    init(noOfRows: CGFloat = .zero) {
        super.init(section: .automaticLayoutDimensions(noOfRows: noOfRows))
    }

    init<Section: Hashable, Row: Hashable>(dataSource: UICollectionViewDiffableDataSource<Section, Row>) {
        super.init { sectionIndex, _ in
            .automaticLayoutDimensions()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSCollectionLayoutSection {
    static func automaticLayoutDimensions(
        insets: NSDirectionalEdgeInsets = .defaultInsets(),
        interItemSpacing: CGFloat = Spacing.space8,
        noOfRows: CGFloat = 0
    ) ->
        NSCollectionLayoutSection {
            
            let item = NSCollectionLayoutItem(layoutSize: .itemSize)
            item.contentInsets = .init(top: Spacing.space8, leading: .zero, bottom: .zero, trailing: .zero)
            
            var groups: [NSCollectionLayoutGroup] = []
            for _ in 0..<1 {
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .itemSize,
                    subitems: [item]
                )
                groups.append(group)
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(Spacing.itemCellSize.width),
                heightDimension: .absolute(Spacing.itemCellSize.height*noOfRows)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: groups
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = interItemSpacing
            section.contentInsets = insets

        // Header Supplimentary View
            section.boundarySupplementaryItems = [.header(rows: noOfRows)]
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}

extension NSCollectionLayoutSize {
    static var itemSize: Self {
        let absoluteHeight: CGFloat = Spacing.itemCellSize.height
        let absoluteWidth: CGFloat = Spacing.itemCellSize.width

        return .init(
            widthDimension: .absolute(absoluteWidth),
            heightDimension: .absolute(absoluteHeight)
        )
    }
    
    static var headerSize: Self {
        let absoluteHeight: CGFloat = Spacing.headerCellSize.height
        let absoluteWidth: CGFloat = Spacing.headerCellSize.width

        return .init(
            widthDimension: .absolute(absoluteWidth),
            heightDimension: .absolute(absoluteHeight)
        )
    }
}

extension NSCollectionLayoutBoundarySupplementaryItem {
    static func header(rows: CGFloat = .zero) -> Self {
        let headerLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Spacing.headerCellSize.width),
            heightDimension: .absolute(rows * Spacing.headerCellSize.height)
        )
        let header: Self = .init(
            layoutSize: headerLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .leading,
            absoluteOffset: CGPoint(x: -Spacing.itemCellSize.width, y: 0)
        )
        header.pinToVisibleBounds = true
        header.zIndex = 2
        
        return header
    }
}

extension NSDirectionalEdgeInsets {
    static func defaultInsets(
        top: CGFloat = Spacing.zero,
        leading: CGFloat = Spacing.headerCellSize.width+Spacing.space8,
        bottom: CGFloat = Spacing.zero,
        trailing: CGFloat = Spacing.zero
    ) -> NSDirectionalEdgeInsets {
        .init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }
}

struct Spacing {
    struct Size {
        let height: CGFloat
        let width: CGFloat
    }
    static let space4: CGFloat = 4
    static let zero: CGFloat = 0
    static let space8: CGFloat = 8
    static let space16: CGFloat = 16
    static let headerCellSize: Size = .init(height: 100, width: 120)
    static let itemCellSize: Size = .init(height: 100, width: 200)
}
