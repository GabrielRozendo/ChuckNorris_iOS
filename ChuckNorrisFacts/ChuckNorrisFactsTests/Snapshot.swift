//
//  HomeViewControllerSnapshot.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import FBSnapshotTestCase

class Snapshot: FBSnapshotTestCase {
    var appCoordinator: AppCoordinator!

    override func setUp() {
        super.setUp()
        recordMode = false

//        appCoordinator = AppCoordinator(window: UIWindow())
//        appCoordinator!.start()
    }

    func testHomeViewController() {
//        FBSnapshotVerifyView(homeVC.view)
//        FBSnapshotVerifyLayer(homeVC.view.layer)
    }

    func testSearchViewController() {
//        FBSnapshotVerifyView(searchVC.view)
//        FBSnapshotVerifyLayer(searchVC.view.layer)
    }
}
