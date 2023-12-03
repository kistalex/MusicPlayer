//
//
// MusicPlayer
// PlayerButtonsStackView.swift
// 
// Created by Alexander Kist on 22.08.2023.
//


import UIKit
import SnapKit

class PlayerButtonsView: UIView {
    
    var backButtonAction: (() -> Void)?
    var playButtonAction: (() -> Void)?
    var forwardButtonAction: (() -> Void)?
    
    private var buttonsStackView: UIStackView!
    lazy var backwardButton = UIButton()
    lazy var playButton = UIButton()
    lazy var forwardButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        configureStackView()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureStackView()
        configureButtons()
    }
    
    private func configureStackView() {
        buttonsStackView = UIStackView(arrangedSubviews: [backwardButton, playButton, forwardButton])
        addSubview(buttonsStackView)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fill
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 20
        
        buttonsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureButtons() {
        backwardButton.setImage(UIImage(named: "backward"), for: .normal)
        backwardButton.tintColor = .label
        
        playButton.setImage(UIImage(named: "circle.fill.play"), for: .normal)
        playButton.tintColor = .label
        
        forwardButton.setImage(UIImage(named: "forward"), for: .normal)
        forwardButton.tintColor = .label
        
        buttonsStackView.addArrangedSubview(backwardButton)
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(forwardButton)
        
        backwardButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        playButton.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
    }
    
    @objc func backwardButtonTapped(_ sender: UIButton){
        backButtonAction?()
    }
    
    @objc func playButtonTapped(_ sender: UIButton){
        playButtonAction?()
    }

    @objc func forwardButtonTapped(_ sender: UIButton){
        forwardButtonAction?()
    }
}

