

//
//
// MusicPlayer
// SongInfoView.swift
//
// Created by Alexander Kist on 22.08.2023.
//

import UIKit
import SnapKit

class SongInfoView: UIView {
    
    private let stackView = UIStackView()
    private let songNameLabel = UILabel()
    private let artistNameLabel = UILabel()
    
    var viewModel: PlayerViewModel?{
        didSet{
            updateUI()
        }
    }
    
    
    init() {
        super.init(frame: .zero)
        configureStackView()
        configureLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureStackView()
        configureLabels()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.alignment = .leading
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateUI(){
        guard let viewModel = viewModel else {
            return
        }
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
    }
    
    private func configureLabels() {
        artistNameLabel.textColor = .label
        songNameLabel.textColor = .label
        
        artistNameLabel.alpha = 0.7
        songNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        stackView.addArrangedSubview(songNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
    }
}
