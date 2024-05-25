//
//  DefaultAPIProvider.swift
//  GIF_Search
//
//  Created by 동준 on 5/22/24.
//

import Foundation

final class DefaultAPIProvider: APIProvider {
    var session: URLSession = .shared
    
    func request<T>(_ request: T, completion: @escaping (Result<T.APIResponse, APIError>) -> Void) where T : APIRequest {
        guard let urlRequest = request.urlRequest else { return
        }
        
        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return completion(.failure(.invaildResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.invaildData))
            }
            
            let decoder = JSONDecoder()
            guard let decoded = try? decoder.decode(T.APIResponse.self, from: data) else {
                return completion(.failure(.parsingError))
            }
            
            return completion(.success(decoded))
        }
        
        task.resume()
    }
}
