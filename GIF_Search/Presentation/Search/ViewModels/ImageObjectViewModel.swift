//
//  ImageInfoViewModel.swift
//  GIF_Search
//
//  Created by 동준 on 5/31/24.
//

import Foundation

struct ImageObjectViewModel {
    var image: Gif
    var aspectRatio: Double
}

extension ImageObjectViewModel {
    init(image: Gif) {
        self.image = image
        self.aspectRatio = image.imageCollection.originalHeight / image.imageCollection.originalWidth
    }
}
