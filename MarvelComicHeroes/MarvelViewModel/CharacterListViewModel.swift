//
//  CharacterListViewModel.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation
import AppKit

enum CharacterAttributeEnum: String {
    case thumbnail = "thumbnail"
    case title = "title"
    case description = "description"
    case unknown
    
    init?(rawValue: String) {
        switch (rawValue) {
        case "thumbnail": self = .thumbnail
        case "title": self = .title
        case "description": self = .description
        default: self = .unknown
        }
    }
}


class CharacterListViewModel: NSObject {
    private var characters: [MarvelCharacter]! = []
    private let service = MarvelAPIService.shared
    private var offset = 0
    
    // Function to load more data when needed.
    func loadData(completion: @escaping (Error?) -> Void) {
        var loadError: Error?
        service.requestMarvelCharacters(offset: offset, amount: maximumItemsToFetch) { result in
            switch result {
            case .success(let response): self.characters.append(contentsOf: response.characters)
                self.offset += maximumItemsToFetch
            case .failure(let error): loadError = error
            }
            completion(loadError)
        }
    }
    
    var count: Int {
        return characters.count
    }
}

extension CharacterListViewModel {
    subscript(index: Int, attribute: CharacterAttributeEnum) -> Any? {
        get {
            guard index < count else { return nil }
            let character = characters[index]
            
            switch (attribute){
            case .thumbnail: return NSImage(systemSymbolName: "pencil", accessibilityDescription: nil)
            case .title: return character.name
            case .description: return character.description
            default: return nil
            }
        }
    }
}
                        
                        
                        
                        

