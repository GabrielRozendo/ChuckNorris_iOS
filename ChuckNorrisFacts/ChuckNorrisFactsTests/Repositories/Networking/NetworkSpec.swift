//
//  NetworkSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class NetworkSpec: QuickSpec {
    override func spec() {
        describe("A network manager") {
            context("With utils") {
                it("Should return handler correctly") {
                    let resultFailure = Result<Any, NetworkError>.failure(NetworkError.unknown)
                    expect(resultFailure.isFailure).to(beTrue())
                    expect(resultFailure.isSuccess).to(beFalse())

                    let resultSuccess = Result<String, NetworkError>.success("success 🎉")
                    expect(resultSuccess.isFailure).to(beFalse())
                    expect(resultSuccess.isSuccess).to(beTrue())
                }
            }
        }
    }
}
