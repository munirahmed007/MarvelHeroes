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
    
    init(rawValue: String) {
        switch (rawValue) {
        case "thumbnail": self = .thumbnail
        case "title": self = .title
        case "description": self = .description
        default: self = .unknown
        }
    }
}

protocol MarvelHeroImageDelegate {
    func didFinishLoadingImage(rowIndex: Int)
}

class CharacterListViewModel: NSObject {
    private var characters: [MarvelCharacter]! = []
    private let service = MarvelAPIService.shared
    private var offset = 0
    var delegate: MarvelHeroImageDelegate?
    
    
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
    
    func fetchImage(for imgUrl: String?, rowIndex: Int) -> NSImage {
        guard let imgUrl = imgUrl else { return NSImage(named: NSImage.Name("placeholder"))! }
        
        if let image = service.cachedImage(for: imgUrl, with: .comicList) {
            return image
        }
        
        service.fetchImage(imgURL: imgUrl, with: .comicList) { [rowIndex] result in
            switch result {
            case .success(_): self.delegate?.didFinishLoadingImage(rowIndex: rowIndex)
            default: break
            }
        }
        return NSImage(named: NSImage.Name("placeholder"))!
    }
}

extension CharacterListViewModel {
    subscript(index: Int, attribute: CharacterAttributeEnum) -> Any? {
        get {
            guard index < count else { return nil }
            let character = characters[index]
            var description = (character.description ?? "No description")
            if description.isEmpty {
                description = "No description"
            }
            switch (attribute){
            case .thumbnail: return fetchImage(for: character.imageURL, rowIndex: index)
            case .title: return character.name
            case .description: return description
            default: return nil
            }
        }
    }
}
                        
                        
                        
                        

