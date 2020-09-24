//
//  DataManagerMock.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class DataManagerMock: DataManagerProtocol {
    var categories: [FactCategory]?
    var pastSearches: [PastSearch]

    init() {
        guard let searchResult = SearchResult.parse(jsonFile: "list_jokes") else {
            fatalError("list_jokes.json not found")
        }

        let now = Date()
        pastSearches = [PastSearch(term: "AA", date: now.addingTimeInterval(-1), searchResult: searchResult),
                        PastSearch(term: "BB", date: now, searchResult: searchResult)]
    }

    func saveCategories(with categories: [FactCategory]) {
        self.categories = categories
    }

    func getCategories() -> [FactCategory]? {
        return categories
    }

    func savePastSearch(with pastSearch: PastSearch) {
        pastSearches.append(pastSearch)
    }

    func getPastSearch() -> [PastSearch]? {
        return pastSearches
    }
}
