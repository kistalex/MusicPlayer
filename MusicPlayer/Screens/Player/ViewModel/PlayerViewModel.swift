

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
    private var currentPlayerItem: AVPlayerItem?
    private var songs: [SongInfo]
    private var currentIndex: Int
    weak var delegate: PlayerViewModelDelegate?
    
    var onPlayNextSong: ((Bool) -> Void)?
    var onPlayPreviousSong: ((Bool) -> Void)?
    var onPlayPauseSong: ((Bool) -> Void)?

    var onPlaybackTimeChange: ((Float) -> Void)?
    var onDurationChange: ((Float) -> Void)?
    
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
        createURL(url: songs[currentIndex].artworkUrl100)
    }
    var trackPreviewURL: URL? {
        createURL(url: songs[currentIndex].previewURL)
    }

    init(songs: [SongInfo], startIndex: Int) {
        self.songs = songs
        self.currentIndex = startIndex
    }

    func playPreviousSong()  {
        if currentIndex > 0 {
            stopMusic()
            currentIndex -= 1
            playSong(at: currentIndex)
            onPlayNextSong?(true)
            onPlayPreviousSong?(true)
        }
        
        if currentIndex <= 0{
            onPlayPreviousSong?(false)
            print(" назад ")
        }
    }

    func playSong(at index: Int?) {
        guard let trackPreviewURL = trackPreviewURL else {
            return
        }

        if isPlayerActive() {
            audioPlayer?.pause()
            onPlayPauseSong?(true)
        } else {
            playNewItem(from: trackPreviewURL)
            onPlayPauseSong?(false)
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

        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            let seconds = CMTimeGetSeconds(time)
            self?.onPlaybackTimeChange?(Float(seconds))
        }

        let duration: CMTime = playerItem.asset.duration
        let seconds: Float64 = CMTimeGetSeconds(duration)
        onDurationChange?(Float(seconds))

        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

        audioPlayer?.play()
    }


    @objc private func playerDidFinishPlaying() {
        playNextSong()
    }
    
    func playNextSong() {
        if currentIndex < songs.count - 1 {
            stopMusic()
            currentIndex += 1
            playSong(at: currentIndex)
            onPlayNextSong?(true)
            onPlayPreviousSong?(true)
        }
        
        if currentIndex >= songs.count - 1{
            onPlayNextSong?(false)
            print(" вперед ")

        }
    }

    func stopMusic(){
        audioPlayer?.pause()
    }
    
    func seek(to seconds: Float) {
        let targetTime: CMTime = CMTimeMake(value: Int64(seconds), timescale: 1)
        audioPlayer?.seek(to: targetTime)
    }

    private func createURL(url: String) -> URL?{
        URL(string: url)
    }
}
