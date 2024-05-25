//
//  APIError.swift
//  GIF_Search
//
//  Created by 동준 on 5/22/24.
//

import Foundation

enum APIError: Error {
    case invaildURL
    case serverError
    case invaildResponse
    case invaildData
    case parsingError
}
