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
    var categories: [FactCategory] { get }
    var pastSearchesSorted: [PastSearch] { get }

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

    private let dataManager: DataManagerProtocol
    private let service: FactsServiceProtocol
    private var categoriesSet = Set<FactCategory>() {
        didSet { isReady.onNext(true) }
    }

    private var pastSearches = Set<PastSearch>()

    // MARK: - PUBLIC PROPERTIES

    let isReady = BehaviorSubject<Bool>(value: false)
    var categories: [FactCategory] {
        return Array(categoriesSet)
    }

    var pastSearchesSorted: [PastSearch] {
        return pastSearches.sorted(by: { $0.date > $1.date })
    }

    // MARK: - INIT

    init(service: FactsServiceProtocol, dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
        self.service = service

        loadCategories()
        loadPastSearches()
    }

    // MARK: - PRIVATE METHODS

    private func loadCategories() {
        if let categories = dataManager.getCategories(), !categories.isEmpty {
            debugPrint("categories from data manager: \(categories.count)")
            categoriesSet = Set(categories)
            return
        }

        _ = service.categories(success: { categories in
            debugPrint("categories from api: \(categories.count)")
            self.categoriesSet = Set(categories)
            self.dataManager.saveCategories(with: self.categories)
        }, failure: { error in
            debugPrint("fetch categories error: \(error)")
        })
    }

    private func loadPastSearches() {
        let pastArray = dataManager.getPastSearch()?.sorted(by: { $0 > $1 }) ?? []
        pastSearches = Set(pastArray)

        debugPrint("pastSearches: \(pastSearches.count)")
    }
}

// MARK: - EXTENSIONS

extension FactsRepository: FactsRepositoryProtocol {
    func goToSearch(with term: String,
                    success: @escaping FactsSearchHandler,
                    failure: @escaping FactsErrorHandler) -> URLSessionDataTask? {
        return service.search(with: term,
                              success: { [weak self] searchResult in
                                  guard let self = self else { return }

                                  let pastSearch = PastSearch(term: term, searchResult: searchResult)

                                  if let existent = self.pastSearches.first(where: { $0.term == term }) {
                                      existent.date = Date()
                                  } else {
                                      self.pastSearches.insert(pastSearch)
                                  }

                                  self.dataManager.savePastSearch(with: pastSearch)

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
