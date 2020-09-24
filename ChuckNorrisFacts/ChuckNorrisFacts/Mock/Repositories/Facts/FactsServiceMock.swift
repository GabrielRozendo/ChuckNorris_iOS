//
//  FactsServiceMock.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class FactsServiceMock: FactsServiceProtocol {
    func random(with category: FactCategory?,
                success: FactsRandomHandler? = nil,
                failure: FactsErrorHandler? = nil) -> URLSessionDataTask? {
        let jsonFile = category == nil ? "random_nocat" : "random"

        guard let fact = Fact.parse(jsonFile: jsonFile) else {
            failure?(.custom("random.json not found"))
            return nil
        }
        success?(fact)
        return nil
    }

    func categories(success: FactsCategoriesHandler?,
                    failure: FactsErrorHandler?) -> URLSessionDataTask? {
        guard let categories = [FactCategory].parse(jsonFile: "categories")
        else {
            failure?(.custom("categories.json not found"))
            return nil
        }
        success?(categories)
        return nil
    }

    func search(with _: String,
                success: FactsSearchHandler?,
                failure: FactsErrorHandler?) -> URLSessionDataTask? {
        guard let searchResult = SearchResult.parse(jsonFile: "list_jokes") else {
            failure?(.custom("list_jokes.json not found"))
            return nil
        }
        success?(searchResult)
        return nil
    }
}
