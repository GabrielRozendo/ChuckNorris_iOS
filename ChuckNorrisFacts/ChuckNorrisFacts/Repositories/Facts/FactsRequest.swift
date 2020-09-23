//
//  FactsRequest.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

enum FactsRequest: RequestProtocol {
    // MARK: - ENUM

    // MARK: - REQUEST PROPERTIES

    var baseURL: String {
        return "https://api.chucknorris.io/"
    }

    var endpointPath: String {
        return ""
    }

    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        default: return ["Content-Type": "application/json"]
        }
    }

    var params: JSON {
        return [:]
    }

    var jsonDecoder: JSONDecoder {
        return JSONDecoder()
    }

    var httpBody: Data? {
        return nil
    }

    var customConfiguration: URLSessionConfiguration? {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true

        return configuration
    }
}
