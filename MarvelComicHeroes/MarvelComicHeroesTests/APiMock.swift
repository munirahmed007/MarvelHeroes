//
//  File.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 29/07/2023.
//

import Foundation
import AppKit

final class MarvelAPIServiceMock: MarvelAPIServiceProtocol {
    
    var shouldFailRequest: Bool = false
    var totalAmount: Int = 0
    var shouldSimulateMaxAmountRequest: Bool = false
    
    func requestMarvelCharacters(offset: Int?, amount: Int, completion: @escaping (Result<MervelCharacterAPIResponse, Error>) -> Void) {
        if shouldFailRequest {
            completion(.failure((ApiCustomError.invalidData)))
        } else {
            let character = MarvelCharacter.init(id: 1, name: "MyCharacter", description: "This is a Swift Character", imageURL: nil)
            
            let characters = shouldSimulateMaxAmountRequest ? [] : [character]
            let response = MervelCharacterAPIResponse(value: characters, count: totalAmount)
            completion(.success(response))
        }
    }
    
    func requestMarvelComics(of character: MarvelCharacter, offset: Int?, amount: Int, completion: @escaping (Result<MervelComicAPIResponse, Error>) -> Void) {
        if shouldFailRequest {
            completion(.failure((ApiCustomError.invalidData)))
        } else {
            let comic = MarvelComic.init(id: 1, title: "MyComic", imageURL: "http://www.mytest.com")
            let comics = shouldSimulateMaxAmountRequest ? [] : [comic]
            let response = MervelComicAPIResponse(value: comics, count: totalAmount)
            completion(.success(response))
        }
    }
    func fetchImage(imgURL: String, with size: ImageSize, completion: @escaping(Result<NSImage, Error>) -> Void) {
        if shouldFailRequest {
            completion(.failure(ApiCustomError.invalidData))
        } else {
            completion(.success(NSImage(named: "placeholder")!))
        }
    }
}
