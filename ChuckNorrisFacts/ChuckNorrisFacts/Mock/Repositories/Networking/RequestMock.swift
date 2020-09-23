//
//  RequestMock.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class RequestMock: RequestProtocol {
    var customConfiguration: URLSessionConfiguration?
    var baseURL = ""
    var endpointPath = ""
    var method = HTTPMethod.get
    var headers: HTTPHeaders?
    var params = JSON()
    var jsonDecoder = JSONDecoder()
    var httpBody: Data?
}
