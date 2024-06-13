//
//  Gif.swift
//  GIF_Search
//
//  Created by 동준 on 5/20/24.
//

import Foundation

struct Gif {
    let identifier: String
    let user: User?
    let imageCollection: ImageCollection
    let title: String
    let type: MediaType
    let source: String?
}

extension Gif: Hashable { }
