//
//
// MusicPlayer
// ApiManager.swift
// 
// Created by Alexander Kist on 14.08.2023.
//


import Foundation

enum NetworkError: Error{
    case urlError
    case noDataReceived
    case canNotParseData

}

final class ApiManager {
    
    func fetchDataFromAPI(with searchTerm: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void) {
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = [
                URLQueryItem(name: "term", value: searchTerm),
                URLQueryItem(name: "entity", value: "song")
            ]
                    
            guard let url = components?.url else {
                completion(Result.failure(.urlError))
                return
            }
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(Result.failure(.noDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(SearchResult.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(Result.failure(.canNotParseData))
            }
        }
        task.resume()
    }
}

