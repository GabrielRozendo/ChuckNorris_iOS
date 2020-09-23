//
//  FactTableViewCell.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

protocol FactTableViewCellDelegate: class {
    func share(text: String)
    func link(url: String)
}

class FactTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FactTableViewCell"

    private struct Metrics {
        static let iconSize = CGSize(width: 28, height: 28)
        static let iconColor = UIColor.blueNCS
    }

    public var fact: Fact? {
        didSet {
            guard let fact = fact else { return }
            factLabel.apply(fact.value, style: .fact(fontSize: fact.value.factFontSize))
            categoryView.category = fact.category
        }
    }

    public weak var delegate: FactTableViewCellDelegate?

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    private func setupView() {
        addSubview(rootView)

        rootView.addSubview(factLabel)
        rootView.addSubview(categoryView)
        rootView.addSubview(shareButton)
        rootView.addSubview(linkButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: topAnchor,
                                          constant: AppMetrics.defaultMargin),
            rootView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: AppMetrics.defaultMargin),
            rootView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -AppMetrics.defaultMargin),
            rootView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                             constant: -AppMetrics.defaultMargin)
        ])

        NSLayoutConstraint.activate([
            factLabel.topAnchor.constraint(equalTo: rootView.topAnchor,
                                           constant: AppMetrics.defaultMargin),
            factLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor,
                                               constant: AppMetrics.defaultMargin),
            factLabel.trailingAnchor.constraint(equalTo: rootView.trailingAnchor,
                                                constant: -AppMetrics.defaultMargin),

            categoryView.topAnchor.constraint(equalTo: factLabel.bottomAnchor,
                                              constant: AppMetrics.defaultMargin),
            categoryView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor,
                                                  constant: AppMetrics.defaultMargin),
            categoryView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor,
                                                 constant: -AppMetrics.defaultMargin),

            shareButton.trailingAnchor.constraint(equalTo: linkButton.leadingAnchor,
                                                  constant: -AppMetrics.defaultMargin),
            shareButton.bottomAnchor.constraint(equalTo: rootView.bottomAnchor,
                                                constant: -AppMetrics.defaultMargin),

            linkButton.trailingAnchor.constraint(equalTo: rootView.trailingAnchor,
                                                 constant: -AppMetrics.defaultMargin),
            linkButton.bottomAnchor.constraint(equalTo: rootView.bottomAnchor,
                                               constant: -AppMetrics.defaultMargin)

        ])
    }

    private lazy var rootView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addCornerRadius()
        view.accessibilityIdentifier = "RootView"
        return view
    }()

    private lazy var factLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.accessibilityIdentifier = "factLabel"
        label.accessibilityLabel = NSLocalizedString("Fact", comment: "")
        return label
    }()

    private lazy var categoryView: CategoryView = {
        let view = CategoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "categoryView"
        return view
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.share, for: .normal)
        button.imageView?.tintColor = Metrics.iconColor
        button.heightAnchor.constraint(equalToConstant: Metrics.iconSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: Metrics.iconSize.width).isActive = true
        button.addTarget(self, action: #selector(share), for: .touchUpInside)
        button.accessibilityIdentifier = "ShareButton"
        button.accessibilityLabel = NSLocalizedString("Share", comment: "")
        return button
    }()

    private lazy var linkButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.link, for: .normal)
        button.imageView?.tintColor = Metrics.iconColor
        button.heightAnchor.constraint(equalToConstant: Metrics.iconSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: Metrics.iconSize.width).isActive = true
        button.addTarget(self, action: #selector(link), for: .touchUpInside)
        button.accessibilityIdentifier = "LinkButton"
        button.accessibilityLabel = NSLocalizedString("Link", comment: "")
        return button
    }()

    @objc private func share() {
        guard let fact = fact, let delegate = delegate else { return }
        delegate.share(text: fact.url)
    }

    @objc private func link() {
        guard let fact = fact, let delegate = delegate else { return }
        delegate.link(url: fact.url)
    }
}
