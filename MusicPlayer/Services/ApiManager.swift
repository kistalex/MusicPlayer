//
//
// MusicPlayer
// ApiManager.swift
// 
// Created by Alexander Kist on 14.08.2023.
//


import Foundation

final class ApiManager {
    
    func fetchDataFromAPI(with searchTerm: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = [
                URLQueryItem(name: "term", value: searchTerm),
                URLQueryItem(name: "entity", value: "musicTrack")
            ]
            
            guard let url = components?.url else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                completion(.failure(error))
                return
            }
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(SearchResult.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

