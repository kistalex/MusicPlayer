//
//
// MusicPlayer
// Response.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import Foundation

// MARK: - Response
struct Response: Codable {
    let resultCount: Int
    let results: [SongInfo]
}

// MARK: - Result
struct SongInfo: Codable {
    let artistName, trackName: String
    let previewURL: String
    let artworkUrl100: String
    let isStreamable: Bool

    enum CodingKeys: String, CodingKey {
        case artistName, trackName
        case previewURL = "previewUrl"
        case artworkUrl100, isStreamable
    }
}
