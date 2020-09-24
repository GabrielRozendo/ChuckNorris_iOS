//
//  FactsRepository.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PROTOCOL

protocol FactsRepositoryProtocol {
    var isReady: BehaviorSubject<Bool> { get }

    func goToSearch(with term: String,
                    success: @escaping FactsSearchHandler,
                    failure: @escaping FactsErrorHandler) -> URLSessionDataTask?

    func goToCategory(with category: FactCategory?,
                      success: @escaping FactsRandomHandler,
                      failure: @escaping FactsErrorHandler) -> URLSessionDataTask?
}

// MARK: - CLASS

class FactsRepository {
    // MARK: - PRIVATE PROPERTIES

    private let service: FactsServiceProtocol

    // MARK: - PUBLIC PROPERTIES

    let isReady = BehaviorSubject<Bool>(value: true)

    // MARK: - INIT

    init(service: FactsServiceProtocol) {
        self.service = service
    }
}

// MARK: - EXTENSIONS

extension FactsRepository: FactsRepositoryProtocol {
    func goToSearch(with term: String,
                    success: @escaping FactsSearchHandler,
                    failure: @escaping FactsErrorHandler) -> URLSessionDataTask? {
        return service.search(with: term,
                              success: { searchResult in
                                  success(searchResult)
                              },
                              failure: { error in
                                  failure(error)
                              })
    }

    func goToCategory(with category: FactCategory?,
                      success: @escaping FactsRandomHandler,
                      failure: @escaping FactsErrorHandler) -> URLSessionDataTask? {
        return service.random(with: category,
                              success: { fact in
                                  success(fact)
                              },
                              failure: { error in
                                  failure(error)
                              })
    }
}
