////
////
//// MusicPlayer
//// SongInfoStackView.swift
//// 
//// Created by Alexander Kist on 22.08.2023.
////
//
//
//import UIKit
//
//class SongInfoStackView: UIStackView{
//    private let songNameLabel = UILabel()
//    private let artistNameLabel = UILabel()
//    
//    init() {
//        super.init(frame: .zero)
//        configureStackView()
//        configureLabels()
//    }
//    
//    required init(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    private func configureStackView() {
//        axis = .vertical
//        distribution = .fillProportionally
//        spacing = 8
//        alignment = .leading
//    }
//    
//    private func configureLabels() {
//        artistNameLabel.alpha = 0.7
//        
//        songNameLabel.text = "Test&Test"
//        songNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        artistNameLabel.text = "Test"
//        
//        addArrangedSubview(songNameLabel)
//        addArrangedSubview(artistNameLabel)
//    }
//}
