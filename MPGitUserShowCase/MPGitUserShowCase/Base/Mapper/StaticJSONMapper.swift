//
//  StaticJSONMapper.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 22.05.26.
//

import Foundation

struct StaticJSONMapper {

    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        /*
         guard !file.isEmpty,
         let path = Bundle.main.path(forResource: file, ofType: "json"),
         let data = FileManager.default.contents(atPath: path) else {
         print("❌ JSON File not found: \(file).json")
         throw  MappingError.failedToGetContents
         }

         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase
         return try decoder.decode(T.self, from: data)
         */
        guard !file.isEmpty else {
            throw MappingError.failedToGetContents
        }

        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            print("❌ JSON File not found: \(file).json")
            throw MappingError.failedToGetContents
        }

        do {
            let data = try Data(contentsOf: url)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(T.self, from: data)

        } catch {
            print("❌ Decoding Error:", error)
            throw error
        }

    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
