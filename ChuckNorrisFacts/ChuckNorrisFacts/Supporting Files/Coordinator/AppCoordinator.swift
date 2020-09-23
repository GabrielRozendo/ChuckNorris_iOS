//
//  AppCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator {
    // MARK: - PRIVATE PROPERTIES

    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - EXTENSIONS

extension AppCoordinator: Coordinator {
    func start() {}
}
