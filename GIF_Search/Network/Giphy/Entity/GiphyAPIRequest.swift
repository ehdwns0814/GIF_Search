//
//  GiphyAPIRequest.swift
//  GIF_Search
//
//  Created by 동준 on 5/22/24.
//

import Foundation

protocol GiphyAPIRequest: APIRequest { }

extension GiphyAPIRequest {
    var baseURL: URL? {
        return URL(string: "https://api.giphy.com/v1/")
    }
}
