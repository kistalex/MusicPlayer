////
////
//// MusicPlayer
//// SongSettingsStackView.swift
//// 
//// Created by Alexander Kist on 22.08.2023.
////
//
//
//import UIKit
//import SnapKit
//
//class SongSettingsStackView: UIStackView {
//    private let shareButton = UIButton(icon: UIImage(named: "share"), tintColor: .black)
//    private let settingsButton = UIButton(icon: UIImage(named: "three-dots"), tintColor: .black)
//    
//    init() {
//        super.init(frame: .zero)
//        configureStackView()
//        configureButtons()
//    }
//    
//    required init(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    private func configureStackView() {
//        axis = .horizontal
//        distribution = .fillProportionally
//        spacing = 12
//        
//        addArrangedSubview(shareButton)
//        addArrangedSubview(settingsButton)
//    }
//    
//    private func configureButtons() {
//        shareButton.alpha = 0.7
//        settingsButton.alpha = 0.7
//        
//        shareButton.snp.makeConstraints { make in
//            make.width.equalTo(25)
//            make.height.equalTo(25)
//        }
//        
//        settingsButton.snp.makeConstraints { make in
//            make.width.equalTo(25)
//            make.height.equalTo(25)
//        }
//        
//        
//    }
//}
