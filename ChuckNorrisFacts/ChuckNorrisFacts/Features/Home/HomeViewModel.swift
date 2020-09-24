//
//  HomeViewModel.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PROTOCOL

protocol HomeViewModelProtocol {
    var errorObservable: PublishSubject<NetworkError> { get }
    var reloadObservable: PublishSubject<Bool> { get }
    var loadingObservable: BehaviorSubject<Bool> { get }

    var facts: [Fact] { get }
    var isDirty: Bool { get }

    func didLoad()
    func goToSearch(with term: String)
    func goToCategory(with category: FactCategory?)
}

// MARK: - CLASS

class HomeViewModel {
    // MARK: - PRIVATE PROPERTIES

    private let disposeBag = DisposeBag()
    private var currentTask: URLSessionDataTask?
    private let factsRepository: FactsRepositoryProtocol

    // MARK: - PUBLIC PROPERTIES

    let errorObservable = PublishSubject<NetworkError>()
    let reloadObservable = PublishSubject<Bool>()
    let loadingObservable = BehaviorSubject<Bool>(value: true)

    private(set) var facts: [Fact] = [] {
        didSet {
            isDirty = true
            reloadObservable.onNext(true)
        }
    }

    private(set) var isDirty = false

    // MARK: - INIT

    init(repository: FactsRepositoryProtocol) {
        self.factsRepository = repository
    }
}

// MARK: - EXTENSION

extension HomeViewModel: HomeViewModelProtocol {
    func didLoad() {
        factsRepository.isReady.subscribe { event in
            if event.element ?? false {
                self.loadingObservable.onNext(false)
            }
        }.disposed(by: disposeBag)
    }

    func goToSearch(with term: String) {
        loadingObservable.onNext(true)
        facts = []

        currentTask?.cancel()
        currentTask = nil

        currentTask = factsRepository.goToSearch(with: term,

                                                 success: { [weak self] searchResult in
                                                     self?.facts = searchResult.result
                                                     self?.loadingObservable.onNext(false)
                                                 },

                                                 failure: { [weak self] error in
                                                     self?.errorObservable.onNext(error)
                                                     self?.loadingObservable.onNext(false)
                                                 })
    }

    func goToCategory(with category: FactCategory?) {
        facts = []

        currentTask?.cancel()
        currentTask = nil

        currentTask = factsRepository.goToCategory(with: category,

                                                   success: { [weak self] fact in
                                                       self?.facts = [fact]
                                                       self?.loadingObservable.onNext(false)
                                                   },

                                                   failure: { [weak self] error in
                                                       self?.errorObservable.onNext(error)
                                                       self?.loadingObservable.onNext(false)
                                                   })
    }
}
