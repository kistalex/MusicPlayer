////
////
//// MusicPlayer
//// PlayerButtonsStackView.swift
//// 
//// Created by Alexander Kist on 22.08.2023.
////
//
//
//import UIKit
//import SnapKit
//
//class PlayerButtonsStackView: UIStackView{
//    private let backButton = UIButton(icon: UIImage(named: "backward"), tintColor: .black)
//    private let playButton = UIButton(icon: UIImage(named: "circle.fill.play"), tintColor: .black)
//    private let nextButton = UIButton(icon: UIImage(named: "forward"), tintColor: .black)
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
//        distribution = .fill
//        alignment = .center
//        spacing = 20
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        addArrangedSubview(backButton)
//        addArrangedSubview(playButton)
//        addArrangedSubview(nextButton)
//    }
//    
//    private func configureButtons() {
//        backButton.snp.makeConstraints { make in
//            make.width.equalTo(30).labeled("width back")
//            make.height.equalTo(30).labeled("height back")
//        }
//        
//        playButton.snp.makeConstraints { make in
//            make.width.equalTo(70).labeled("width play")
//            make.height.equalTo(70).labeled("height play")
//        }
//        
//        playButton.imageView?.tintColor = .white
//        nextButton.imageView?.tintColor = .white
//        backButton.imageView?.tintColor = .white
//        
//        nextButton.snp.makeConstraints { make in
//            make.width.equalTo(30).labeled("width forward")
//            make.height.equalTo(30).labeled("height forward")
//        }
//         
//        
//    }
//}
