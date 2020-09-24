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

    case categories
    case random(category: FactCategory? = nil)
    case search(term: String)

    // MARK: - REQUEST PROPERTIES

    var baseURL: String {
        return "https://api.chucknorris.io/"
    }

    var endpointPath: String {
        switch self {
        case .categories: return "jokes/categories"
        case .random: return "jokes/random"
        case .search: return "jokes/search"
        }
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
        switch self {
        case let .random(category):
            if let category = category {
                return ["category": category]
            }
            return [:]

        case let .search(term): return ["query": term]

        default: return [:]
        }
    }

    var jsonDecoder: JSONDecoder {
        switch self {
        default:
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

            return jsonDecoder
        }
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
