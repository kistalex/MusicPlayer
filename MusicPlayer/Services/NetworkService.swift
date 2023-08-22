//
//
// MusicPlayer
// NetworkService.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit


class NetworkService {
    
    
    func loadImageFromURL(urlAddress: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlAddress) else {
            if let defaultImage = UIImage(systemName: "eye.slash.circle") {
                completion(defaultImage)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                if let defaultImage = UIImage(systemName: "eye.slash.circle") {
                    completion(defaultImage)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("Invalid response")
                if let defaultImage = UIImage(systemName: "eye.slash.circle") {
                    completion(defaultImage)
                }
                return
            }
            
            guard let imageData = data, let loadedImage = UIImage(data: imageData) else {
                print("Invalid image data")
                if let defaultImage = UIImage(systemName: "eye.slash.circle") {
                    completion(defaultImage)
                }
                return
            }
            
            completion(loadedImage)
        }
        task.resume()
    }
}

