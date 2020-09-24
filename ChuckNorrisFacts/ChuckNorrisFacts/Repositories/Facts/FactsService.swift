//
//  FactsService.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

// MARK: - TYPEALIAS

typealias FactsErrorHandler = (NetworkError) -> Void
typealias FactsRandomHandler = (Fact) -> Void
typealias FactsCategoriesHandler = ([FactCategory]) -> Void
typealias FactsSearchHandler = (SearchResult) -> Void

// MARK: - PROTOCOL

protocol FactsServiceProtocol {
    func random(with category: FactCategory?,
                success: FactsRandomHandler?,
                failure: FactsErrorHandler?) -> URLSessionDataTask?
    func categories(success: FactsCategoriesHandler?,
                    failure: FactsErrorHandler?) -> URLSessionDataTask?
    func search(with term: String,
                success: FactsSearchHandler?,
                failure: FactsErrorHandler?) -> URLSessionDataTask?
}

// MARK: - CLASS

class FactsService {
    // MARK: - PRIVATE PROPERTIES

    private let networkManager: NetworkManagerProtocol

    // MARK: - INIT

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - EXTENSIONS

extension FactsService: FactsServiceProtocol {
    func random(with category: FactCategory?,
                success: FactsRandomHandler? = nil,
                failure: FactsErrorHandler? = nil) -> URLSessionDataTask? {
        let request = FactsRequest.random(category: category)
        return networkManager.makeRequest(with: request) { (result: ResultHandler<Fact>) in
            switch result {
            case let .success(joke):
                if let joke = joke {
                    success?(joke)
                } else {
                    failure?(.noData)
                }
            case let .failure(error): failure?(error)
            }
        }
    }

    func categories(success: FactsCategoriesHandler? = nil,
                    failure: FactsErrorHandler? = nil) -> URLSessionDataTask? {
        let request = FactsRequest.categories
        return networkManager.makeRequest(with: request) { (result: ResultHandler<[FactCategory]>) in
            switch result {
            case let .success(categories):
                if let categories = categories {
                    success?(categories)
                } else {
                    failure?(.noData)
                }
            case let .failure(error): failure?(error)
            }
        }
    }

    func search(with term: String,
                success: FactsSearchHandler? = nil,
                failure: FactsErrorHandler? = nil) -> URLSessionDataTask? {
        let request = FactsRequest.search(term: term)
        return networkManager.makeRequest(with: request) { (result: ResultHandler<SearchResult>) in
            switch result {
            case let .success(searchResult):
                if let searchResult = searchResult {
                    success?(searchResult)
                } else {
                    failure?(.noData)
                }
            case let .failure(error): failure?(error)
            }
        }
    }
}
