//
//  ImageCaching.swift
//  MovieDiary
//
//  Created by Ivan on 27.08.2026.
//

import UIKit

class ImageCaching: ImageCachingProtocol {
    
    static let shared = ImageCaching()
     
    private let cache = NSCache <NSString, UIImage>()
    
    private init() {
        
        cache.countLimit = 100
        cache.totalCostLimit = 1000 * 1000 * 100
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void ) {
     
        let cacheKey = NSString(string: url)
        
        
        // check if the iimage is in the cache
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            
            completion(.success(cachedImage))
            return
        }
        
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, errror in
            
            if let error = errror {
                
                completion(.failure(APIError.networkError(error)))
                
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completion(.success(image))
            
        }.resume()
    }
}


protocol ImageCachingProtocol: AnyObject {
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
