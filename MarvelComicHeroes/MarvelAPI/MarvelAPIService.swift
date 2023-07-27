//
//  MarvelAPI.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation
import CryptoSwift
import Alamofire
import AlamofireImage
import AppKit

enum ImageSize: String {
    case comicList = "portrait_medium"
    case heroList = "portrait_xlarge"
    case heroDetail = "landscape_xlarge"
}

enum ApiCustomError: Error {
    case invalidData
}

protocol MarvelAPIServiceProtocol {
    func requestMarvelCharacters(offset: Int?, amount: Int, completion: @escaping(Result<MervelCharacterAPIResponse, Error>) -> Void)
    
    func requestMarvelComics(of character: MarvelCharacter, offset: Int?, amount: Int, completion: @escaping(Result<MervelComicAPIResponse, Error>) -> Void)
    func fetchImage(imgURL: String, with size: ImageSize, completion: @escaping(Result<NSImage, Error>) -> Void)
}

final class MarvelAPIService: MarvelAPIServiceProtocol {
    private let basePath = MarvelApiConstants.apiUrl
    static let shared = MarvelAPIService()
    private lazy var charactersEndpoint = "\(basePath)\(MarvelApiConstants.charactersEndpoint)"
    private lazy var comicsEndpoint = "\(basePath)\(MarvelApiConstants.charactersEndpoint)/%@\(MarvelApiConstants.comicsEndpoint)"
    
    private lazy var defaultParams: [String: Any] = {
        let ts = "\(Date().timeIntervalSinceNow)"
        let hash = "\(ts)\(MarvelRequestKey.marvelPrivateKey)\(MarvelRequestKey.marvelPublicKey)".md5()
        return [
            MarvelRequestKey.timestampKey: ts,
            MarvelRequestKey.hashKey: hash,
            MarvelRequestKey.publicKey: MarvelRequestKey.marvelPublicKey
        ]
    }()
    
    // Handles image caching
    private let imageCache = AutoPurgingImageCache()
    
    func requestMarvelCharacters(offset: Int? = 0, amount: Int, completion: @escaping(Result<MervelCharacterAPIResponse, Error>) -> Void) {
        performGenericRequest(withPath: charactersEndpoint, offset: offset!, amount: amount, completion: completion)
    }
    
    func requestMarvelComics(of character: MarvelCharacter, offset: Int? = 0, amount: Int, completion: @escaping(Result<MervelComicAPIResponse, Error>) -> Void) {
        let path = String(format: comicsEndpoint, "\(character.id)")
        performGenericRequest(withPath: path, offset: offset!, amount: amount, completion: completion)
    }
    
    func fetchImage(imgURL: String, with size: ImageSize, completion: @escaping(Result<NSImage, Error>) -> Void) {
        let imgPath = String(format: imgURL, size.rawValue)
        if let cachedImg = imageCache.image(withIdentifier: imgPath) {
            completion(.success(cachedImg))
            return
        }
        
        AF.request(imgPath,
                          method: .get,
                          parameters: defaultParams,
                          encoding: URLEncoding(destination: .queryString),
                          headers: nil)
            .validate()
            .responseImage { [unowned self] response in
                switch response.result {
                case .success(let img):
                    self.imageCache.add(img, withIdentifier: imgURL)
                    completion(.success(img))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private func performGenericRequest<T: Decodable>(withPath path: String, offset: Int, amount: Int, completion: @escaping(Result<MarvelAPIResponse<T>, Error>) -> Void) {
        var params = defaultParams
        params[MarvelApiConstants.limit] = amount
        params[MarvelApiConstants.offset] = offset
        
        AF.request(path,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding(destination: .queryString),
                          headers: nil)
            .validate()
            .responseDecodable(of: MarvelAPIResponse<T>.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let afError):
                    completion(.failure(afError as Error))
            }
        }
    }
}

