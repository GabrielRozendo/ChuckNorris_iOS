//
//  CategoryCollectionDelegate.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

// MARK: - PROTOCOL

protocol CategoryCollectionDelegate: class {
    func categoryDidTap(with category: FactCategory)
}

// MARK: - CLASS

class CategoryCollectionHeader: UITableViewCell {
    // MARK: - PUBLIC PROPERTIES

    static let reuseIdentifier = "CategoryCollectionViewCell"

    var categories: [FactCategory] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    weak var delegate: CategoryCollectionDelegate?

    // MARK: - PRIVATE ENUM

    private enum Metrics {
        static let numberOfItemsInRow: CGFloat = 3
    }

    // MARK: - INIT

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    private func setupView() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: AppMetrics.defaultMargin),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppMetrics.defaultMargin),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppMetrics.defaultMargin),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -AppMetrics.defaultMargin)
        ])
    }

    // MARK: - UI

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical

        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)

        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.allowsSelection = true
        collection.allowsMultipleSelection = false

        collection.accessibilityIdentifier = "CollectionView"
        collection.accessibilityLabel = NSLocalizedString("CategoryCollection", comment: "")
        collection.register(CategoryCollectionItemViewCell.self,
                            forCellWithReuseIdentifier: CategoryCollectionItemViewCell.reuseIdentifier)

        return collection
    }()
}

// MARK: - EXTENSION

extension CategoryCollectionHeader: UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionItemViewCell.reuseIdentifier,
            for: indexPath
        ) as? CategoryCollectionItemViewCell
        else { return UICollectionViewCell() }

        cell.category = categories[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.categoryDidTap(with: categories[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - AppMetrics.defaultMargin
        let width = collectionViewSize / Metrics.numberOfItemsInRow
        return CGSize(width: width, height: 48)
    }
}
