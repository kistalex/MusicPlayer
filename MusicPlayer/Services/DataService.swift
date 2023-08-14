//
//
// MusicPlayer
// DataService.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import Foundation

class DataService {
    func fetchBannerData(fromFileNamed fileName: String, completion: @escaping (Result<Response, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let songInfo = try decoder.decode(Response.self, from: jsonData)
                completion(.success(songInfo))
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "DataService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data file not found"])
            completion(.failure(error))
        }
    }
}
