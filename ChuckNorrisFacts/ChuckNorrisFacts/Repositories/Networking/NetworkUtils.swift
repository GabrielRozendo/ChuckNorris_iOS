//
//  NetworkUtils.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

// MARK: - TYPEALIAS

typealias JSON = [String: Any]
typealias HTTPHeaders = [String: String]
typealias ResultHandler<T> = Result<T?, NetworkError>
typealias ResultCallback<T> = (ResultHandler<T>) -> Void

// MARK: - ENUM

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - EXTENSIONS

extension Result {
    var isFailure: Bool {
        switch self {
        case .failure: return true
        case .success: return false
        }
    }

    var isSuccess: Bool {
        switch self {
        case .failure: return false
        case .success: return true
        }
    }
}
