//
//  MarvelAPIConstants.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation

struct MarvelApiConstants {
    /// Mavel API & Cosntants
    static let apiUrl = "https://gateway.marvel.com/v1/public"
    static let charactersEndpoint = "/characters"
    static let comicsEndpoint = "/comics"
    
    static let limit = "limit"
    static let offset = "offset"
}

/// Marvel Request Constants
struct MarvelRequestKey {
    static let timestampKey = "ts"
    static let hashKey = "hash"
    static let publicKey = "apikey"
    static let marvelPublicKey = "0c037a86592b89a57cb59ce222fcc14e"
    static let marvelPrivateKey = "817c4627fbdb6d150a39d91379b474699f51eb9c"
}

let maximumItemsToFetch: Int = 20
