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

class RequestParamsSpec: QuickSpec {
    override func spec() {
        describe("A request") {
            let request = RequestMock()

            context("with parameters setup") {
                it("should return nil as parameter when doesnt have any") {
                    request.params = [:]
                    expect(request.queryItems).to(beNil())
                }

                it("should return the parameter in url as well") {
                    let baseURL = "https://baseURL"
                    let endpoint = "/endpoint"
                    let paramKey = "param1"
                    let paramValue = 1
                    let params = [paramKey: paramValue]

                    request.baseURL = baseURL
                    request.endpointPath = endpoint
                    request.params = params

                    let expectation = "\(baseURL)\(endpoint)?\(paramKey)=\(paramValue)"
                    expect(request.urlRequest?.url?.absoluteString).to(equal(expectation))
                }

                it("should return the parameters in url as well") {
                    let baseURL = "https://baseURL"
                    let endpoint = "/endpoint"
                    let param1Key = "param1"
                    let param1Value = 1

                    let param2Key = "param2"
                    let param2Value = 2

                    let params = [param1Key: param1Value, param2Key: param2Value]

                    request.baseURL = baseURL
                    request.endpointPath = endpoint
                    request.params = params

                    let url = request.urlRequest?.url?.absoluteString
                    let absoluteString = url?.components(separatedBy: "?").last?.components(separatedBy: "&")

                    expect(absoluteString?.count).to(equal(params.count))
                    expect(absoluteString?.contains("\(param1Key)=\(param1Value)")).to(beTrue())
                    expect(absoluteString?.contains("\(param2Key)=\(param2Value)")).to(beTrue())
                }
            }
        }
    }
}
