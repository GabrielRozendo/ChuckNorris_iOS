//
//  Decodable+Extension.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

extension Decodable {
    static func parse(jsonFile: String, withExtension: String = ".json", subdirectory: String? = nil) -> Self? {
        guard let url = Bundle.main.url(forResource: jsonFile,
                                        withExtension: withExtension,
                                        subdirectory: subdirectory),
            let data = try? Data(contentsOf: url)

        else {
            return nil
        }

        do {
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

            let output = try jsonDecoder.decode(self, from: data)
            debugPrint(output)
            return output
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
