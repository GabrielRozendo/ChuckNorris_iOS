//
//  NetworkError.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidEndpoint
    case invalidRequest
    case noInternetConnection
    case noData
    case unauthorized
    case notFound
    case serverError
    case decodeError
    case custom(String)
    case unknown
}

// MARK: - EXTENSIONS

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidEndpoint: return "invalidEndpoint"
        case .invalidRequest: return "invalidRequest"
        case .noInternetConnection: return "noInternetConnection"
        case .noData: return "noData"
        case .unauthorized: return "unauthorized"
        case .notFound: return "notFound"
        case .serverError: return "serverError"
        case .decodeError: return "decodeError"
        case .custom(let str): return "custom: " + str
        case .unknown: return "unknown"
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.description == rhs.description
    }
}
