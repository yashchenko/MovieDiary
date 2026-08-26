//
//  FetchMovie.swift
//  MovieDiary
//
//  Created by Ivan on 15.08.2026.
//

import Foundation

class TMDBRemoteAPI: RemoteAPI {
    
    private let url = "https://api.themoviedb.org/3"
    
    private let apiKey = "6cdd2d3baafa5a8956a81cca80b33617"
    
    init() { }
    
    func fetchMovies(pages: Int, completion: @escaping (Result<[MovieEntity], APIError>) -> Void) {
        
        let urlString = "\(url)/movie/popular?api_key=\(apiKey)&language=ru-RU&page=\(pages)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("Данные пришли: \(data)")
            
            if let error = error {
                
                print("Ошибка сети: \(error)")
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), let data = data else {
                print("Ошибка статуса: response")
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                
                let decpde = try JSONDecoder().decode(MoviePageEntity.self, from: data)
                completion(.success(decpde.results))
                
                
            } catch let decodingError {
                print("Ошибка парсинга: \(decodingError)")
                completion(.failure(.decodingError(decodingError)))
                
            }
            
        }
        
        task.resume()
    }
}
