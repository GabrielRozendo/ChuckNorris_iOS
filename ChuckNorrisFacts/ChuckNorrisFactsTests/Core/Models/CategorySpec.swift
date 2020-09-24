//
//  CategorySpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class CategorySpec: QuickSpec {
    override func spec() {
        describe("A Category model") {
            context("with the mock json files") {
                it("should decode from the list") {
                    let categories = [FactCategory].parse(jsonFile: "categories")
                    expect(categories).to(beAKindOf([FactCategory].self))
                    expect(categories).toNot(beEmpty())
                }
            }
        }
    }
}
