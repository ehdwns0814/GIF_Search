//
//  CacheManager.swift
//  GIF_Search
//
//  Created by 동준 on 6/2/24.
//

import UIKit
import AVFoundation

final class CacheManager {
    static let imageCache = URLCache(
        memoryCapacity: 400 * 1024 * 1024,
        diskCapacity: 1000 * 1024 * 1024,
        directory: nil
    )
    
    static let videoCache = NSCache<NSString, AVURLAsset>()
    
    static func fetchImage(imageURL: URL, completionHandler: @escaping (Data) -> Void) {
        let request = URLRequest(url: imageURL)
        
        self.fetchImageFromCache(request: request) { result in
            switch result {
            case .success(let imageData):
                completionHandler(imageData)
            case .failure:
                self.downloadImage(request: request) { imageData in
                    completionHandler(imageData)
                }
            }
        }
    }
    
    static func fetchVideo(videoURL: URL, completionHandler: @escaping (AVURLAsset) -> Void) {
        if let cachedVideo = self.videoCache.object(forKey: videoURL.absoluteString as NSString) {
            completionHandler(cachedVideo)
        } else {
            DispatchQueue.global().async {
                let asset = AVURLAsset(url: videoURL)
                self.videoCache.setObject(asset, forKey: videoURL.absoluteString as NSString)
                completionHandler(asset)
            }
        }
    }
    
    private static func downloadImage(request: URLRequest, completion: @escaping (Data) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
            }
            let cachedResponse = CachedURLResponse(response: response, data: data)
            self.imageCache.storeCachedResponse(cachedResponse, for: request)
            
            completion(data)
        }
        dataTask.resume()
    }
    
    static func fetchImageFromCache(request: URLRequest, completionHandler: @escaping (Result<Data, CacheError>) -> Void) {
        if let imageData = self.imageCache.cachedResponse(for: request)?.data {
            completionHandler(.success(imageData))
        } else {
            completionHandler(.failure(.cachedImageNotFound))
        }
    }
}

enum CacheError: Error {
    case cachedImageNotFound
    case invalidImageCacheData
}
