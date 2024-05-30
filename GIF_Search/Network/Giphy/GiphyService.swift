//
//  GiphyService.swift
//  GIF_Search
//
//  Created by 동준 on 5/26/24.
//

import Foundation

protocol GiphyService {
    func searchGif(
        type: MediaType,
        query: String,
        offset: Int,
        completion: @escaping ((Result<GifBundle, APIError>) -> Void)
    ) 
}
