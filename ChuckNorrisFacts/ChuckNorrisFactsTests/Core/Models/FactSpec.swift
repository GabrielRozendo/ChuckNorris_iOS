//
//  FactSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class FactSpec: QuickSpec {
    override func spec() {
        describe("A Fact model") {
            context("with the mock json files") {
                it("should decode from a random") {
                    let fact = Fact.parse(jsonFile: "random")
                    expect(fact).to(beAKindOf(Fact.self))
                    expect(fact?.category).toNot(beEmpty())
                }

                it("should decode from a random without category") {
                    let fact = Fact.parse(jsonFile: "random_nocat")
                    expect(fact).to(beAKindOf(Fact.self))
                    expect(fact?.category).toNot(beEmpty())
                }
            }
        }
    }
}
