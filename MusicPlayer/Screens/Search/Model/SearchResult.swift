//
//
// MusicPlayer
// Response.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [SongInfo]
}


struct SongInfo: Codable {
    let artistName, trackName: String
    let previewURL: String
    let artworkUrl100: String

    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case trackName = "trackName"
        case previewURL = "previewUrl"
        case artworkUrl100 = "artworkUrl100"
    }
}


