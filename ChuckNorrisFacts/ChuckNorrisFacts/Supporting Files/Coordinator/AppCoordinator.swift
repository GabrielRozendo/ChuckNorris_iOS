//
//  AppCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

// MARK: - PROTOCOL

protocol Coordinator {
    func start()
}

// MARK: - CLASS

class AppCoordinator {
    // MARK: - PRIVATE PROPERTIES

    private let window: UIWindow
    private let navigationController: UINavigationController
    private let homeCoordinator: HomeCoordinator

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()

        let network = NetworkManager(reachability: Reachability.self)
        let service = FactsService(networkManager: network)
        let dataManager = DataManager()
        let repository = FactsRepository(service: service, dataManager: dataManager)

        homeCoordinator = HomeCoordinator(presenter: navigationController, repository: repository)

        setupNavigationController()
        window.rootViewController = navigationController
    }

    // MARK: - PRIVATE METHODS

    private func setupNavigationController() {
        navigationController.view.backgroundColor = .white

        let normalAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: AppTextStyle.title(fontSize: 16).font,
             NSAttributedString.Key.foregroundColor: UIColor.flame]

        let largeAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: AppTextStyle.title(fontSize: 20).font,
             NSAttributedString.Key.foregroundColor: UIColor.flame]

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = normalAttributes
        navBarAppearance.largeTitleTextAttributes = largeAttributes
        navBarAppearance.backgroundColor = .white
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController.navigationBar.tintColor = .flame
    }
}

// MARK: - EXTENSIONS

extension AppCoordinator: Coordinator {
    func start() {
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
