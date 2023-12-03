//
//
// MusicPlayer
// SongSettingsStackView.swift
// 
// Created by Alexander Kist on 22.08.2023.
//


import UIKit
import SnapKit

class SongSettingsView: UIView {
    private let stackView: UIStackView
    private let shareButton = UIButton(type: .custom)
    private let settingsButton = UIButton(type: .custom)
    
    init() {
        stackView = UIStackView()
        super.init(frame: .zero)
        configureStackView()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        stackView = UIStackView()
        super.init(coder: coder)
        configureStackView()
        configureButtons()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureButtons() {
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.tintColor = .label
        shareButton.alpha = 0.8
        
        settingsButton.setImage(UIImage(named: "three-dots"), for: .normal)
        settingsButton.tintColor = .label
        settingsButton.alpha = 0.8
        
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(settingsButton)
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
    }
}
