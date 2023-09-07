//
//
// MusicPlayer
// PlayerViewModel.swift
// 
// Created by Alexander Kist on 25.08.2023.
//


import Foundation
import AVFoundation



protocol PlayerViewModelDelegate: AnyObject {
    func trackDidUpdate(_ viewModel: PlayerViewModel, track: SongInfo)
}

class PlayerViewModel{

    private var audioPlayer: AVPlayer?
    private var songs: [SongInfo]
    private var currentIndex: Int
    weak var delegate: PlayerViewModelDelegate?

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

    init(songs: [SongInfo], startIndex: Int) {
        self.songs = songs
        self.currentIndex = startIndex
    }

    func playPreviousSong() {
        if currentIndex > 0 {
            stopMusic()
            currentIndex -= 1
            playSong(at: currentIndex)
        }
    }

    func playSong(at index: Int) {
        guard let trackPreviewURL = trackPreviewURL else {
            return
        }

        if isPlayerActive() {
            audioPlayer?.pause()
        } else {
            playNewItem(from: trackPreviewURL)
        }
        
        delegate?.trackDidUpdate(self, track: songs[currentIndex])
    }

    private func isPlayerActive() -> Bool {
        if let player = audioPlayer, player.timeControlStatus == .playing {
            return true
        }
        return false
    }
    
    private func playNewItem(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
    
    func playNextSong() {
        if currentIndex < songs.count - 1 {
            stopMusic()
            currentIndex += 1
            playSong(at: currentIndex)
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
