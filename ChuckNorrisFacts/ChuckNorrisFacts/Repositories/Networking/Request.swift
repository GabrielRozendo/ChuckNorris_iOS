//
//  Request.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var baseURL: String { get }
    var endpointPath: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var params: JSON { get }
    var jsonDecoder: JSONDecoder { get }
    var httpBody: Data? { get }
    var customConfiguration: URLSessionConfiguration? { get }
}

// MARK: - EXTENSIONS

extension RequestProtocol {
    var queryItems: [URLQueryItem]? {
        if params.isEmpty {
            return nil
        }

        return params.compactMap {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
    }

    var path: String {
        return (endpointPath.hasPrefix("/") ? "" : "/") + endpointPath
    }

    var components: URLComponents? {
        guard let url = URL(string: baseURL),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        components.path = path
        if [HTTPMethod.get, HTTPMethod.delete].contains(method) {
            components.queryItems = queryItems
        }

        return components
    }

    var urlRequest: URLRequest? {
        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }

    var configuration: URLSessionConfiguration {
        if let configuration = customConfiguration {
            return configuration
        }

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true

        return configuration
    }
}
