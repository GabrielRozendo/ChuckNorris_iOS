//
//  HomeViewControllerSnapshot.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import FBSnapshotTestCase

class HomeViewControllerSnapshot: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func homeViewController() {
        let homeVM = HomeViewModel()
        let homeVC = HomeViewController(with: homeVM)

        let coordinator = HomeCoordinator(presenter: UINavigationController(), homeVM: homeVM, homeVC: homeVC)
        coordinator.start()

        FBSnapshotVerifyView(homeVC.view, identifier: "homeVC")
        FBSnapshotVerifyLayer(homeVC.view.layer)
    }
}
