//
//  FactsRepositorySpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class FactsRepositorySpec: QuickSpec {
    override func spec() {
        var dataManagerMock: DataManagerMock!
        var serviceMock: FactsServiceMock!
        var repository: FactsRepository!

        describe("A Jokes Repository") {
            beforeEach {
                dataManagerMock = DataManagerMock()
                serviceMock = FactsServiceMock()
                repository = FactsRepository(service: serviceMock, dataManager: dataManagerMock)
            }

            context("after being initialized with mock") {
                it("should return is not ready right after that") {
                    expect(try repository.isReady.value()).to(beTrue())
                }
            }
        }
    }
}
