//
//  PastSearch.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class PastSearch: Codable {
    let term: String
    var date: Date
    let searchResult: SearchResult?

    init(term: String, date: Date = Date(), searchResult: SearchResult? = nil) {
        self.term = term.trimmingCharacters(in: .whitespacesAndNewlines)
        self.date = date
        self.searchResult = searchResult
    }
}

// MARK: - EXTENSIONS

extension PastSearch: Hashable {
    static func == (lhs: PastSearch, rhs: PastSearch) -> Bool {
        return lhs.term == rhs.term
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(term)
    }
}

extension PastSearch: Comparable {
    static func < (lhs: PastSearch, rhs: PastSearch) -> Bool {
        return lhs.date < rhs.date
    }
}
