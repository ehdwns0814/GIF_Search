//
//  APIRequest.swift
//  GIF_Search
//
//  Created by 동준 on 5/22/24.
//

import Foundation

protocol APIRequest {
    associatedtype APIResponse: Decodable
    
    var method: HTTPMethod { get }
    var baseURL: URL? { get }
    var path: String { get }
    var url: URL? { get }
    var headers: [String: String]? { get}
    var parameters: [String: String] { get }
}

extension APIRequest {
    var url: URL? {
        guard let url = self.baseURL?.appendingPathComponent(self.path) else {
            return nil
        }
        var urlComponents = URLComponents(string: url.absoluteString)
        let urlQuery = self.parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        urlComponents?.queryItems = urlQuery
        
        return urlComponents?.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        if let headers = self.headers {
            headers.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
