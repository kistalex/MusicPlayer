//
//
// MusicPlayer
// SongCell.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit
import SnapKit
import SDWebImage


final class SongCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(viewModel: SongCellViewModel) {
       artistNameLabel.text = viewModel.artistName
       songNameLabel.text = viewModel.trackName
       songImageView.sd_setImage(with: viewModel.trackCover)
    }
    
    override func prepareForReuse() {
        artistNameLabel.text = nil
        songNameLabel.text = nil
        songImageView.sd_setImage(with: nil)
    }
    
    //MARK: - Private properties
    private enum Constants{
        static let viewPadding: CGFloat = 10
        static let songImageWidth: CGFloat = 50
        static let settingsImageSize: CGFloat = 20
    }
    
    
    private let songImageView = UIImageView(contentMode: .scaleAspectFit)
    
    private let songNameLabel = UILabel()
    
    private let artistNameLabel = UILabel()
    
    private let settingsImageView = UIImageView(image: UIImage(systemName: "ellipsis"), contentMode: .scaleAspectFit, tintColor: .black)
    
    private var songInfoStack: UIStackView!
    
    //MARK: - Private methods
    
    private func setupSongInfoStack(){
        songInfoStack = UIStackView(arrangedSubviews: [songNameLabel, artistNameLabel])
        songInfoStack.axis = .vertical
        songInfoStack.distribution = .fillProportionally
        songInfoStack.spacing = 8
    }
    private func setupUI(){
        setupSongInfoStack()
        
        contentView.addSubview(songImageView)
        contentView.addSubview(songInfoStack)
        contentView.addSubview(settingsImageView)
        
        songImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(Constants.viewPadding)
            make.top.equalTo(contentView.snp.top).offset(Constants.viewPadding)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constants.viewPadding)
            make.width.equalTo(Constants.songImageWidth)
        }

        songInfoStack.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.viewPadding)
            make.leading.equalTo(songImageView.snp.trailing).offset(Constants.viewPadding)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constants.viewPadding)
        }

        settingsImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.viewPadding)
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(songInfoStack.snp.trailing).offset(Constants.viewPadding)
            make.width.equalTo(Constants.settingsImageSize)
            make.height.equalTo(Constants.settingsImageSize)
        }
    }
}

