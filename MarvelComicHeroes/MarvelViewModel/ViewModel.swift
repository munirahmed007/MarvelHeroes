//
//  ViewModel.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 28/07/2023.
//

import Foundation
import AppKit


protocol MarvelHeroImageDelegate {
    func didFinishLoadingImage(rowIndex: Int)
}

protocol ViewModel {
    func loadData(completion: @escaping (Error?) -> Void)
    func fetchImage(for imgUrl: String?, rowIndex: Int) -> NSImage
    var count: Int { get }
    var service: MarvelAPIServiceProtocol { get set }
    var delegate: MarvelHeroImageDelegate? { get set }
}
    
    
extension ViewModel {
    func fetchImage(for imgUrl: String?, rowIndex: Int) -> NSImage {
        guard let imgUrl = imgUrl else { return NSImage(named: NSImage.Name("placeholder"))! }
        
        if let service = service as? MarvelAPIService {
            if let image = service.cachedImage(for: imgUrl, with: .comicList) {
                return image
            }
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
