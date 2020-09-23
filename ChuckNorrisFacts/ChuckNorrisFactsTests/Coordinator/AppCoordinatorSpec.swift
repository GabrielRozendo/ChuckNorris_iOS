//
//  AppCoordinatorSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class AppCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("A App Coordinator") {
            var coordinator: AppCoordinator!

            beforeEach {
                coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
                coordinator.start()
            }

            context("After start") {}

            context("After assign delegates") {
                it("should conform to coordinator") {
                    expect(coordinator).to(beAKindOf(Coordinator.self))
                }

                it("should not conform to HomeViewControllerDelegate") {
                    expect(coordinator).toNot(beAKindOf(HomeViewControllerDelegate.self))
                }
            }
        }
    }
}
