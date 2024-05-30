//
//  DefaultGiphyService.swift
//  GIF_Search
//
//  Created by 동준 on 5/26/24.
//

import Foundation

final class DefaultGiphyService: GiphyService {
    let apiService: APIProvider
    
    init(apiService: APIProvider) {
        self.apiService = apiService
    }
    
    func searchGif(type: MediaType, query: String, offset: Int, completion: @escaping ((Result<GifBundle, APIError>) -> Void)) {
        let request = GifSearchRequest(query: query)
        return self.apiService.request(request) { result in
            let convertedOutput = result.map { $0.castToGifBundle() }
            completion(convertedOutput)
        }
    }
}
