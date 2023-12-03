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
    
    //MARK: - Private properties
    
    private enum Constants{
        static let viewPadding: CGFloat = 10
        static let songImageWidth: CGFloat = 50
        static let settingsImageSize: CGFloat = 20
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
    
    //MARK: - Private methods
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
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.viewPadding),
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewPadding),
            songImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.viewPadding),
            songImageView.widthAnchor.constraint(equalToConstant: Constants.songImageWidth),
            
            songInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewPadding),
            songInfoStack.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: Constants.viewPadding),
            songInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.viewPadding),
            
            settingsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.viewPadding),
            settingsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingsImageView.leadingAnchor.constraint(equalTo: songInfoStack.trailingAnchor, constant: Constants.viewPadding),
            settingsImageView.widthAnchor.constraint(equalToConstant: Constants.settingsImageSize),
            settingsImageView.heightAnchor.constraint(equalToConstant: Constants.settingsImageSize)
        ])
    }
}
