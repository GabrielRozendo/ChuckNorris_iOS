//
//  FactsRepositoryMock.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation
import RxSwift

class FactsRepositoryMock: FactsRepositoryProtocol {
    let isReady = BehaviorSubject<Bool>(value: true)
    var pastSearchesSorted: [PastSearch] = []
    var categories: [FactCategory] = []

    func goToSearch(with _: String,
                    success _: @escaping FactsSearchHandler,
                    failure _: @escaping FactsErrorHandler) -> URLSessionDataTask? {
        return nil
    }

    func goToCategory(with _: FactCategory?,
                      success _: @escaping FactsRandomHandler,
                      failure _: @escaping FactsErrorHandler) -> URLSessionDataTask? {
        return nil
    }
}
