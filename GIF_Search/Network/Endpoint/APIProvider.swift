//
//  APIProvider.swift
//  GIF_Search
//
//  Created by 동준 on 5/22/24.
//

import Foundation

protocol APIProvider {
    var session: URLSession { get }
    
    func request<T: APIRequest>(_ request: T, completion: @escaping (Result<T.APIResponse, APIError>) -> Void)
}
