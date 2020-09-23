//
//  SearchCoordinatorSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class SearchCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("A Search Coordinator") {
            var coordinator: SearchCoordinator!
            var presenter: UINavigationController!
            let categories: [FactCategory] = ["AA", "BB"]

            beforeEach {
                presenter = UINavigationController()
                coordinator = SearchCoordinator(presenter: presenter, categories: categories, pastSearches: [])
                coordinator.start()
            }

            context("After start") {
                it("should have Search View Controller in navigation") {
                    expect(presenter.viewControllers.count).to(equal(1))
                    expect(presenter.viewControllers.first).to(beAKindOf(SearchViewController.self))
                }

                it("should have the localized title") {
                    let localizedTitle = NSLocalizedString("search title", comment: "")
                    expect(presenter.viewControllers.first?.title).to(equal(localizedTitle))
                }

                it("should NOT have nothing as bar button item") {
                    let rightButton = presenter.viewControllers.first?.navigationItem.rightBarButtonItem
                    expect(rightButton).to(beNil())
                }

                it("should have assign the view controller delegate") {
                    let searchVC = presenter.viewControllers.first as? SearchViewController
                    expect(searchVC?.delegate).toNot(beNil())
                }
            }

            context("After assign delegates") {
                it("should conform to coordinator") {
                    expect(coordinator).to(beAKindOf(Coordinator.self))
                }
                it("should conform to SearchViewControllerDelegate") {
                    expect(coordinator).to(beAKindOf(SearchViewControllerDelegate.self))
                }
            }
        }
    }
}
