//
//  GifSearchResponse+Extension.swift
//  GIF_Search
//
//  Created by 동준 on 5/26/24.
//

import Foundation

extension GifSearchResponse {
    func castToGifBundle() -> GifBundle {
        let offset = pagination.offset
        let target = min(pagination.totalCount, 4999)
        let isNextPage = offset < target
        return GifBundle(
            offset: offset,
            hasNextPage: isNextPage,
            gifs: responseData.compactMap { $0.castToGif() }
        )
    }
}

extension SearchGifResponse {
    func castToGif() -> Gif? {
        guard let type = MediaType(rawValue: self.type) else {
            return nil
        }
        
        return Gif(
            identifier: identifier,
            user: user?.castToUser(),
            imageCollection: images.castToImageCollection(),
            title: title
        )
    }
}

extension UserResponse {
    func castToUser() -> User {
        return User(
            name: username,
            profileURL: profileURL,
            displayName: displayName
        )
    }
}

extension ImageResponse {
    func castToImageCollection() -> ImageCollection {
        return ImageCollection(imageURL: fixedWidth.url)
    }
}
