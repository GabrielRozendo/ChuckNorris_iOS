//
//  SearchCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

// MARK: - PROTOCOL

protocol SearchCoordinatorDelegate: class {
    func goToSearch(with term: String)
    func goToCategory(with category: FactCategory)
}

// MARK: - CLASS

class SearchCoordinator {
    // MARK: - PRIVATE PROPERTIES

    private let presenter: UINavigationController
    private let categories: [FactCategory]
    private let pastSearches: [PastSearch]
    private var searchVC: SearchViewController?

    // MARK: - PUBLIC PROPERTIES

    weak var delegate: SearchCoordinatorDelegate?

    // MARK: - INIT

    init(presenter: UINavigationController,
         categories: [FactCategory],
         pastSearches: [PastSearch],
         searchVC: SearchViewController? = nil) {
        self.presenter = presenter
        self.categories = categories
        self.pastSearches = pastSearches
        self.searchVC = searchVC
    }

    // MARK: - PRIVATE METHODS

    private func preparation(in searchVC: SearchViewController) {
        searchVC.view.backgroundColor = .white
        searchVC.title = NSLocalizedString("search title", comment: "Title of search view")
    }
}

// MARK: - EXTENSION COORDINATOR

extension SearchCoordinator: Coordinator {
    func start() {
        let viewModel = SearchViewModel(with: categories, pastSearches: pastSearches)
        let searchVC = SearchViewController(with: viewModel)
        searchVC.delegate = self

        preparation(in: searchVC)
        presenter.pushViewController(searchVC, animated: true)
        self.searchVC = searchVC
    }
}

// MARK: - EXTENSION DELEGATES

extension SearchCoordinator: SearchViewControllerDelegate {
    func goToSearch(with term: String) {
        presenter.popViewController(animated: true)
        delegate?.goToSearch(with: term)
    }

    func goToCategory(with category: FactCategory) {
        presenter.popViewController(animated: true)
        delegate?.goToCategory(with: category)
    }
}
