//
//  ComicListViewModel.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 28/07/2023.
//

import Cocoa

class ComicListViewModel: ViewModel {
    private var character: MarvelCharacter
    private var comicList: [MarvelComic] = []
 
    var delegate: MarvelHeroImageDelegate?
    var service = MarvelAPIService.shared

    init(character: MarvelCharacter) {
        self.character = character
    }
    
    // Function to load more data when needed.
    func loadData(completion: @escaping (Error?) -> Void) {
        var loadError: Error?
        service.requestMarvelComics(of: character, amount: maximumItemsToFetch) { result in
            switch result {
            case .success(let response): self.comicList.append(contentsOf: response.commics)
            case .failure(let error): loadError = error
            }
            completion(loadError)
        }
    }
    
    var count: Int {
        return comicList.count
    }
}

extension ComicListViewModel {
    subscript(index: Int) -> MarvelComic? {
        guard index < count else { return nil }
        return comicList[index]
    }
}
