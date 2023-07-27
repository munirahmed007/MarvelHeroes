//
//  MarvelComic+API.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Foundation

/// API related comic response extension
extension MarvelComic {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
    }
    
    enum ThumbnailInfo: String, CodingKey {
        case path
        case imgExtension = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        
        let thumbnailInfo = try values.nestedContainer(keyedBy: ThumbnailInfo.self, forKey: .thumbnail)
        let pathToImage = try thumbnailInfo.decode(String.self, forKey: .path)
        let imgExtenstion = try thumbnailInfo.decode(String.self, forKey: .imgExtension)
        imageURL = pathToImage + "/%@." + imgExtenstion
    }
}
