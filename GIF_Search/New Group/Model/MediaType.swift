//
//  MediaType.swift
//  GIF_Search
//
//  Created by 동준 on 5/26/24.
//

import Foundation

enum MediaType: String, CaseIterable {
    case gif
    case sticker
    
    var description: String {
        switch self {
        case .gif:
            return "GIF"
        case .sticker:
            return "Sticker"
        }
    }
}

extension MediaType {
    init?(index: Int) {
        switch index {
        case 0:
            self = .gif
        case 1:
            self = .sticker
        default:
            return nil
        }
    }
}
