//
//  SearchViewModelSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class SearchViewModelSpec: QuickSpec {
    override func spec() {
        describe("A Search ViewModel") {
            let categories = ["animal", "career", "celebrity", "dev", "explicit",
                              "fashion", "food", "history", "money", "movie",
                              "music", "political", "religion", "science", "sport", "travel"]

            let searchVM = SearchViewModel(with: categories, pastSearches: [])
            context("after populate some categories") {
                it("should return the categories 8 randomly") {
                    let list1 = searchVM.categoriesToShow
                    let list2 = searchVM.categoriesToShow

                    expect(list1.count).to(equal(8))
                    expect(list2.count).to(equal(8))
                    expect(list1).toNot(equal(list2))
                }
            }
        }
    }
}
