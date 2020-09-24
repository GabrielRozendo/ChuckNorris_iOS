//
//  PastSearch.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import CoreData
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

    enum CoreDataFields: String {
        case term
        case date
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

// MARK: - EXTENSION CORE DATA

extension PastSearch {
    static func factory<PastSearch>(from object: NSManagedObject) -> PastSearch? {
        return nil
    }

    func setValue(with object: NSManagedObject) {
        object.setValue(term, forKey: CoreDataFields.term.rawValue)
        object.setValue(date, forKey: CoreDataFields.date.rawValue)
    }

    static func factory(from object: NSManagedObject) -> PastSearch? {
        guard
            let term = object.value(forKey: CoreDataFields.term.rawValue) as? String,
            let date = object.value(forKey: CoreDataFields.date.rawValue) as? Date
        else { return nil }

        return PastSearch(term: term, date: date)
    }
}
