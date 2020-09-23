//
//  HomeCoordinatorSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class HomeCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("A Home Coordinator") {
            var coordinator: HomeCoordinator!
            var presenter: UINavigationController!

            beforeEach {
                presenter = UINavigationController()
                coordinator = HomeCoordinator(presenter: presenter)
                coordinator.start()
            }

            context("After start") {
                it("should have only one view controller in navigation") {
                    expect(presenter.viewControllers.count).to(equal(1))
                }

                it("should have navigation controller as Home View Controller") {
                    let firstController = presenter.viewControllers.first
                    expect(firstController).to(beAKindOf(HomeViewController.self))
                }

                it("should have the localized title") {
                    let localizedTitle = NSLocalizedString("home title", comment: "")
                    expect(presenter.viewControllers.first?.title).to(equal(localizedTitle))
                }

                it("should have the search bar button item") {
                    let rightButton = presenter.viewControllers.first?.navigationItem.rightBarButtonItem
                    expect(rightButton).toNot(beNil())
                }

                it("should have assign the view controller delegate") {
                    let homeVC = presenter.viewControllers.first as? HomeViewController
                    expect(homeVC?.delegate).toNot(beNil())
                }
            }

            context("After assign delegates") {
                it("should conform to coordinator") {
                    expect(coordinator).to(beAKindOf(Coordinator.self))
                }

                it("should conform to HomeViewControllerDelegate") {
                    expect(coordinator).to(beAKindOf(HomeViewControllerDelegate.self))
                }
            }
        }
    }
}
