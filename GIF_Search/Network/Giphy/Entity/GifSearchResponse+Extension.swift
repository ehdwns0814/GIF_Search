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
            title: title,
            type: type,
            source: self.source == "" ? nil : self.source
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
        let originalWidth = Double(self.original.width) ?? 100
        let originalHeight = Double(self.original.height) ?? 100
        return ImageCollection(
            imageURL: self.original.url,
            originalWidth: originalWidth,
            originalHeight: originalHeight,
            mp4URL: self.fixedWidth.mp4
        )
    }
}
