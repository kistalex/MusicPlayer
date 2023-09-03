//
//
// MusicPlayer
// PlayerViewModel.swift
// 
// Created by Alexander Kist on 25.08.2023.
//


import Foundation
import AVFoundation

class PlayerViewModel{
    
    private var audioPlayer: AVPlayer?
    private var songs: [SongInfo]
    private var currentIndex: Int
    
    var id: Int {
        songs[currentIndex].trackID
    }
    var trackName: String {
        songs[currentIndex].trackName
    }
    var artistName: String {
        songs[currentIndex].artistName
    }
    var trackCover: URL? {
        createCoverURL(artworkURL: songs[currentIndex].artworkUrl100)
    }
    var trackPreviewURL: URL? {
        createPreviewURL(previewURL: songs[currentIndex].previewURL)
    }
    
    init(songs: [SongInfo], startIndex: Int = 0) {
        self.songs = songs
        self.currentIndex = startIndex
    }
    
    func playPreviousSong() {
        if currentIndex > 0 {
            currentIndex -= 1
            playSong()
        }
    }
    
    func playSong() {
        guard let trackPreviewURL = trackPreviewURL else {
            return
        }
        
        let playerItem = AVPlayerItem(url: trackPreviewURL)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
    
    func playNextSong() {
        if currentIndex < songs.count - 1 {
            currentIndex += 1
            playSong()
        }
    }
    
    func stopMusic(){
        audioPlayer?.pause()
    }
    
    private func createCoverURL(artworkURL: String) -> URL?{
        URL(string: artworkURL)
    }
    
    private func createPreviewURL(previewURL: String) -> URL?{
        URL(string: previewURL)
    }
}
