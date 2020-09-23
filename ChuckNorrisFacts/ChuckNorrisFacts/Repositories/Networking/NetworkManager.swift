//
//  NetworkManager.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeRequest<T: Codable>(with request: RequestProtocol,
                                 completion: @escaping ResultCallback<T>) -> URLSessionDataTask?
}

class NetworkManager {
    // MARK: - PRIVATE PROPERTIES

    private let reachability: ReachabilityProtocol.Type

    // MARK: - INIT

    init(reachability: ReachabilityProtocol.Type) {
        self.reachability = reachability
    }

    // MARK: - PRIVATE METHODS

    private func handleStatusCode<T: Codable>(_ statusCode: Int, _ data: Data, _ completion: ResultCallback<T>) {
        switch statusCode {
        case 200 ..< 300: handleData(data, completion: completion)
        case 400: completion(.failure(.invalidRequest))
        case 401: completion(.failure(.unauthorized))
        case 404: completion(.failure(.notFound))
        case 500...: completion(.failure(.serverError))
        default: completion(.failure(.unknown))
        }
    }

    private func handleData<T: Codable>(_ data: Data, completion: ResultCallback<T>) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch let jsonError {
            debugPrint(jsonError)
            completion(.failure(.decodeError))
        }
    }
}

// MARK: - EXTENSIONS

extension NetworkManager: NetworkManagerProtocol {
    func makeRequest<T: Codable>(with request: RequestProtocol,
                                 completion: @escaping ResultCallback<T>) -> URLSessionDataTask? {
        if !reachability.isConnectedToNetwork {
            completion(.failure(.noInternetConnection))
            return nil
        }

        guard let urlRequest = request.urlRequest else {
            completion(.failure(.invalidRequest))
            return nil
        }

        let urlSession = URLSession(configuration: request.configuration)

        let dataTask = urlSession.dataTask(with: urlRequest) { [unowned self] data, response, error in
            debugPrint(urlRequest)

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.noData))
            }

            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }

            debugPrint(response.statusCode)

            if response.statusCode == 204 {
                completion(.success(nil))
                return
            }

            guard let data = data else {
                debugPrint("No data")
                completion(.failure(.noData))
                return
            }

            debugPrint(String(data: data, encoding: .utf8) ?? "no response")

            self.handleStatusCode(response.statusCode, data, completion)
        }
        dataTask.resume()
        return dataTask
    }
}
