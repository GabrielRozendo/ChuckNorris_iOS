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

    // MARK: - INIT

    init(presenter: UINavigationController) {
        self.presenter = presenter
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

// MARK: - EXTENSIONS

extension HomeCoordinator: Coordinator {
    func start() {
        let homeVM = HomeViewModel()
        self.homeVM = homeVM
        let homeVC = HomeViewController(with: homeVM)
        homeVC.delegate = self

        preparation(with: homeVC)

        presenter.pushViewController(homeVC, animated: true)
        self.homeVC = homeVC
    }
}

// MARK: - DELEGATES

extension HomeCoordinator: HomeViewControllerDelegate {
    func goToSearch() {}
}
