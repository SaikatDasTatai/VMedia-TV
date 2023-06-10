//
//  CompositionLayout.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 10/06/23.
//

import UIKit

class CompositionLayout: UICollectionViewCompositionalLayout {
    init() {
        super.init(section: .automaticLayoutDimensions())
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
        interItemSpacing: CGFloat = 16
    ) ->
        NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .itemSize)

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .itemSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interItemSpacing

        section.contentInsets = insets

        // Header Supplimentary View
        section.boundarySupplementaryItems = [.header]

        return section
    }
}

extension NSCollectionLayoutSize {
    static var itemSize: Self {
        let estimatedHeight: CGFloat = 1.0
        let fractionalWidth: CGFloat = 1.0

        return .init(
            widthDimension: .fractionalWidth(fractionalWidth),
            heightDimension: .estimated(estimatedHeight)
        )
    }
}

extension NSCollectionLayoutBoundarySupplementaryItem {
    static var header: Self {
        .init(
            layoutSize: .itemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension NSDirectionalEdgeInsets {
    static func defaultInsets(
        top: CGFloat = Spacing.space8,
        leading: CGFloat = Spacing.space16,
        bottom: CGFloat = Spacing.space8,
        trailing: CGFloat = Spacing.space16
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
    static let space8: CGFloat = 8
    static let space16: CGFloat = 16
}
