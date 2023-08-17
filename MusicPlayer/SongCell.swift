//
//
// MusicPlayer
// SongCell.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit

class SongCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with song: SongInfo) {
        networkService.loadImageFromURL(urlAddress: song.artworkUrl100) { [weak self] image in
            DispatchQueue.main.async {
                self?.songImageView.image = image
            }
        }
        songNameLabel.text = song.trackName
        artistNameLabel.text = song.artistName
    }
    
    private let networkService = NetworkService()
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "ellipsis")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var songInfoStack: UIStackView!
        
    private func setupUI(){
        
        songInfoStack = UIStackView(arrangedSubviews: [songNameLabel, artistNameLabel])
        songInfoStack.axis = .vertical
        songInfoStack.distribution = .fillProportionally
        songInfoStack.spacing = 8
        songInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(songImageView)
        contentView.addSubview(songInfoStack)
        contentView.addSubview(settingsImageView)
        
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            songImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            songImageView.widthAnchor.constraint(equalToConstant: 50),
            
            songInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            songInfoStack.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 10),
            songInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            settingsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            settingsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingsImageView.leadingAnchor.constraint(equalTo: songInfoStack.trailingAnchor, constant: 10),
            settingsImageView.widthAnchor.constraint(equalToConstant: 20),
            settingsImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
