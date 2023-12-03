//
//
// MusicPlayer
// SongCellViewModel.swift
// 
// Created by Alexander Kist on 30.08.2023.
//


import Foundation

class SongCellViewModel {
    
    var id: Int
    var trackName: String
    var artistName: String
    var trackCover: URL?
    var trackPreviewURL: URL?
    
    init(song: SongInfo) {
        self.id = song.trackID
        self.trackName = song.trackName
        self.artistName = song.artistName
        self.trackCover = createCoverURL(artworkURL: song.artworkUrl100)
    }
    
    private func createCoverURL(artworkURL: String) -> URL?{
        URL(string: artworkURL)
    }
    
    private func createPreviewURL(previewURL: String) -> URL?{
        URL(string: previewURL)
    }
    
}
