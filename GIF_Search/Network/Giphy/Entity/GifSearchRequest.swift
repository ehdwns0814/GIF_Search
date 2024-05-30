//
//  GifSearchRequest.swift
//  GIF_Search
//
//  Created by 동준 on 5/25/24.
//

import Foundation

struct GifSearchRequest: GiphyAPIRequest {
    typealias APIResponse = GifSearchResponse
    
    let APIKey = Bundle.main.infoDictionary?["APIKey"] as! String
    let method: HTTPMethod = .get
    let path: String = "gifs/search"
    let headers: [String : String]? = nil
    let query: String
    let bundle: String = "clips_grid_picker"
    
    var parameters: [String : String] {
        [
            "api_key": APIKey,
            "q": query,
            "bundle": bundle
        ]
    }
}
