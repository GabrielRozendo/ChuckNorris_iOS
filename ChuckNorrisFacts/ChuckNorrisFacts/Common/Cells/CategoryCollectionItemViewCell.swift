//
//  CategoryCollectionItemViewCell.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

// MARK: -

class CategoryCollectionItemViewCell: UICollectionViewCell {
    // MARK: - PUBLIC PROPERTIES

    static var reuseIdentifier: String = "CategoryCollectionViewCell"

    var category: FactCategory? {
        didSet {
            titleLabel.text = category
        }
    }

    // MARK: - INIT

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        backgroundColor = .blueNCS
        addCornerRadius(20, borderWidth: 0.5, borderColor: UIColor.blueNCS.darker(by: 50).cgColor)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply("", style: .category(), customColor: .white)
        label.textAlignment = .center

        label.accessibilityIdentifier = "titleLabel"
        label.accessibilityLabel = NSLocalizedString("Category", comment: "")
        return label
    }()
}
