//
//  RequestSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class RequestSpec: QuickSpec {
    override func spec() {
        describe("A request") {
            let request = RequestMock()

            context("with url setup") {
                it("should return the full path correctly") {
                    let baseURL = "https://baseURL"
                    let endpoint = "/endpoint"

                    request.baseURL = baseURL
                    request.endpointPath = endpoint

                    expect(request.urlRequest?.url?.absoluteString).to(equal("\(baseURL)\(endpoint)"))
                }

                it("should return the full path correctly even without /") {
                    let baseURL = "https://baseURL"
                    let endpoint = "endpoint"

                    request.baseURL = baseURL
                    request.endpointPath = endpoint

                    expect(request.urlRequest?.url?.absoluteString).to(equal("\(baseURL)/\(endpoint)"))
                }
            }

            context("in configuration") {
                it("should add a default configuration") {
                    request.customConfiguration = nil
                    expect(request.configuration).toNot(beNil())
                }

                it("should return the custom configuration if setup") {
                    let customConfiguration = URLSessionConfiguration.default
                    request.customConfiguration = customConfiguration

                    expect(request.configuration).to(equal(customConfiguration))
                }
            }
        }
    }
}
