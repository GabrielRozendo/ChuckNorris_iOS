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
}

// MARK: - CLASS

class HomeViewModel {
    // MARK: - PRIVATE PROPERTIES

    private let disposeBag = DisposeBag()
    private var currentTask: URLSessionDataTask?

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
}

// MARK: - EXTENSION

extension HomeViewModel: HomeViewModelProtocol {
    func didLoad() {
        loadingObservable.onNext(false)
    }
}
