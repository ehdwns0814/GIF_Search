//
//  GifSearchResponse.swift
//  GIF_Search
//
//  Created by 동준 on 5/25/24.
//

import Foundation

struct GifSearchResponse: Decodable {
    let responseData: [SearchGifResponse]
    let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case responseData = "data"
        case pagination
    }
}

struct SearchGifResponse: Decodable {
    let type: String
    let identifier: String
    let username: String
    let title: String
    let images: ImageResponse
    let user: UserResponse?
    let source: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case identifier = "id"
        case username
        case title
        case images
        case user
        case source
    }
}

struct Pagination: Decodable {
    let offset: Int
    let totalCount: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case offset
        case totalCount = "total_count"
        case count
    }
}

struct UserResponse: Decodable {
    let avatarURL: String
    let bannerURL: String
    let profileURL: String
    let username: String
    let displayName: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
    }
}

struct ImageResponse: Decodable {
    let original: OriginalImageResponse
    let fixedWidth: FixedWidthImageResponse
    
    enum CodingKeys: String, CodingKey {
        case original
        case fixedWidth = "fixed_width"
    }
}

struct OriginalImageResponse: Decodable {
    let width: String
    let height: String
    let size: String
    let url: String
    let frames: String
    let mp4: String
    let mp4Size: String
    
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case size
        case url
        case frames
        case mp4
        case mp4Size = "mp4_size"
    }
}

struct FixedWidthImageResponse: Decodable {
    let url: String
    let width: String
    let height: String
    let size: String
    let mp4: String
    let mp4Size: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case size
        case mp4
        case mp4Size = "mp4_size"
    }
}
