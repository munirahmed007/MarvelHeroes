//
//  MarvelHero.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation

/// MarvelHero represent Hero model
struct MarvelCharacter: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let imageURL: String?
}
