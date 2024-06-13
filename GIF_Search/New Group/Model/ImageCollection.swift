//
//  ImageCollection.swift
//  GIF_Search
//
//  Created by 동준 on 5/20/24.
//

import Foundation

struct ImageCollection {
    let imageURL: String
    let originalWidth: Double
    let originalHeight: Double
    let mp4URL: String
}

extension ImageCollection: Hashable { }
