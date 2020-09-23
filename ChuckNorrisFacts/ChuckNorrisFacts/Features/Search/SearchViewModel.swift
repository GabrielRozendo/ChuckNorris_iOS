//
//  SearchViewModel.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

// MARK: - PROTOCOL

protocol SearchViewModelProtocol {
    var categoriesToShow: [FactCategory] { get }
    var pastSearchesTerm: [String] { get }
}

// MARK: - CLASS

final class SearchViewModel {
    // MARK: - INIT

    init(with categories: [FactCategory], pastSearches: [PastSearch]) {
        self.categories = categories
        self.pastSearches = pastSearches
    }

    // MARK: - PROPERTIES

    private let categories: [FactCategory]
    var categoriesToShow: [FactCategory] {
        return Array(categories.shuffled().prefix(8))
    }

    private let pastSearches: [PastSearch]
    var pastSearchesTerm: [String] {
        return pastSearches.compactMap { $0.term }
    }
}

// MARK: - EXTENSION

extension SearchViewModel: SearchViewModelProtocol {}
