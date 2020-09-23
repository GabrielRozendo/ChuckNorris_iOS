//
//  CategoryView.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

protocol CategoryDelegate: class {
    func didTap(category: Category)
}

class CategoryView: UIView {
    private struct Metrics {
        static let margin: CGFloat = 8
    }

    var category: FactCategory? {
        didSet {
            guard let category = category else { return }
            textLabel.apply(category, style: .category(), customColor: .white)
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "CategoryLabel"
        label.accessibilityLabel = NSLocalizedString("Category", comment: "")
        return label
    }()

    private func setup() {
        backgroundColor = .blueNCS
        addCornerRadius()
        addSubview(textLabel)

        addConstraints([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.margin),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.margin),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.margin),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.margin)
        ])
    }
}
