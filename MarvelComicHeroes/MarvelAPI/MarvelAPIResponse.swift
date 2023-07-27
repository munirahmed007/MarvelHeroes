//
//  MarvelAPIResponse.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation

/// struct to help decode Marvel API Response
struct MarvelAPIResponse<T: Decodable>: Decodable {
    let results: T
    let total: Int
    
    /// outer coding keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    /// nested coding keys
    enum NestedCodingKeys: String, CodingKey {
        case results
        case total
    }
    
    /// Decodable initializer
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let additionalInfo = try values.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .data)
        results = try additionalInfo.decode(T.self, forKey: .results)
        total = try additionalInfo.decode(Int.self, forKey: .total)
    }
}

/// a quick extension for characters api response
extension MarvelAPIResponse where T == [MarvelCharacter] {
    var characters: [MarvelCharacter] {
        return results
    }
}

typealias MervelCharacterAPIResponse = MarvelAPIResponse<[MarvelCharacter]>

/// a quick extension for commits api response
extension MarvelAPIResponse where T == [MarvelComic] {
    var commics: [MarvelComic] {
        return results
    }
}
typealias MervelComicAPIResponse = MarvelAPIResponse<[MarvelComic]>
