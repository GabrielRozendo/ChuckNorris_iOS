//
//  HomeCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import RxSwift
import UIKit

class HomeCoordinator {
    // MARK: - PRIVATE PROPERTIES

    private let presenter: UINavigationController
    private var homeVC: HomeViewController?
    private var homeVM: HomeViewModel?
    private var searchCoordinator: SearchCoordinator?
    private var factsRepository: FactsRepositoryProtocol

    // MARK: - INIT

    init(presenter: UINavigationController,
         repository: FactsRepositoryProtocol,
         homeVM: HomeViewModel? = nil,
         homeVC: HomeViewController? = nil) {
        self.presenter = presenter
        self.factsRepository = repository
        self.homeVM = homeVM
        self.homeVC = homeVC
    }

    // MARK: - PRIVATE METHODS

    private func preparation(with homeVC: HomeViewController) {
        let searchButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                               target: homeVC,
                                               action: #selector(homeVC.search))
        searchButtonItem.tintColor = .flame
        searchButtonItem.isEnabled = false
        searchButtonItem.accessibilityIdentifier = "searchButton"
        searchButtonItem.accessibilityLabel = NSLocalizedString("search button", comment: "")

        homeVC.navigationItem.rightBarButtonItem = searchButtonItem

        homeVC.title = NSLocalizedString("home title", comment: "Title of home view")
        homeVC.view.backgroundColor = .white
    }
}

// MARK: - EXTENSION COORDINATOR

extension HomeCoordinator: Coordinator {
    func start() {
        let homeVM = self.homeVM ?? HomeViewModel(repository: factsRepository)
        self.homeVM = homeVM
        let homeVC = self.homeVC ?? HomeViewController(with: homeVM)
        homeVC.delegate = self

        preparation(with: homeVC)

        presenter.pushViewController(homeVC, animated: true)
        self.homeVC = homeVC
    }
}

// MARK: - EXTENSION DELEGATES

extension HomeCoordinator: HomeViewControllerDelegate {
    func goToSearch() {
        searchCoordinator = SearchCoordinator(presenter: presenter, categories: [], pastSearches: [])
        searchCoordinator?.delegate = self
        searchCoordinator?.start()
    }
}

extension HomeCoordinator: SearchCoordinatorDelegate {
    func goToSearch(with term: String) {
        homeVM?.goToSearch(with: term)
    }

    func goToCategory(with category: FactCategory) {
        homeVM?.goToCategory(with: category)
    }
}
