//
//  RequestHeaderSpec.swift
//  ChuckNorrisFactsTests
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

@testable import Chuck_Norris_Facts
import Nimble
import Quick

class RequestHeaderSpec: QuickSpec {
    override func spec() {
        describe("A request") {
            let request = RequestMock()

            it("should add the headers in property") {
                request.baseURL = "baseUrl"
                let header = ["header": "value"]
                request.headers = header
                expect(request.urlRequest?.allHTTPHeaderFields).to(equal(header))
            }
        }
    }
}
