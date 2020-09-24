//
//  SearchResultSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class SearchResultSpec: QuickSpec {
    override func spec() {
        describe("A SearchResultSpec model") {
            context("with the mock json files") {
                it("should decode from the result") {
                    let searchResult = SearchResult.parse(jsonFile: "list_jokes")
                    expect(searchResult).to(beAKindOf(SearchResult.self))
                    expect(searchResult?.total).to(beGreaterThan(0))
                    expect(searchResult?.result).toNot(beEmpty())
                    expect(searchResult?.result.count).to(equal(searchResult?.total))
                }
            }
        }
    }
}
