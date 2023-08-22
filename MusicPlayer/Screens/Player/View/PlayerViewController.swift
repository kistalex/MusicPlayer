//
//
// MusicPlayer
// PlayerViewController.swift
// 
// Created by Alexander Kist on 14.08.2023.
//


import UIKit
import SnapKit

class PlayerViewController: UIViewController {
    
    
    private let coverImageView = UIImageView(image: UIImage(systemName: "music.note"), contentMode: .scaleAspectFit)
    
    private let config = UIImage.SymbolConfiguration(scale: .large)

    lazy var shareButton = UIButton(icon: UIImage(named: "share"),target: self, action: #selector(shareButtonPressed))
    lazy var settingsButton = UIButton(icon: UIImage(named: "three-dots"),target: self, action: #selector(settingsButtonPressed))
    lazy var playButton = UIButton(icon: UIImage(named: "circle.fill.play"),target: self, action: #selector(playButtonPressed))
    lazy var nextButton = UIButton(icon: UIImage(named: "forward"),target: self, action: #selector(nextButtonPressed))
    lazy var backButton = UIButton(icon: UIImage(named: "backward"),target: self, action: #selector(backButtonPressed))
    
    
    
    @objc func shareButtonPressed(){
         print("Нажали поделиться")
    }
    
    @objc func settingsButtonPressed(){
        print("Нажали настройки")
    }
    
    @objc func playButtonPressed(_ visible: Bool){
         print("Нажали play")
    }
    
    @objc func nextButtonPressed(){
        print("Нажали вперед")
    }
    @objc func backButtonPressed(){
         print("Нажали назад")
    }
  
    private let songNameLabel = UILabel()
    private let artistNameLabel = UILabel()
    private var timelineSlider = UISlider()
    private let networkService = NetworkService()

    
    private var songInfoStack: UIStackView!
    private var songSettingsStack: UIStackView!
    private var playerButtonsStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6698819399, blue: 0.6376078725, alpha: 1)
        setupUI()
    }
    
    func configure(with song: SongInfo){
        networkService.loadImageFromURL(urlAddress: song.artworkUrl100) { [weak self] image in
            DispatchQueue.main.async {
                self?.coverImageView.image = image
            }
        }
        songNameLabel.text = song.trackName
        artistNameLabel.text = song.artistName
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    private func setupUI(){
        setupCoverImageView()
        setupSongInfoStack()
        setupSongSettingsStack()
        setupTimelineSlider()
        setupPlayerButtonsStack()
    }
    
    private func setupTimelineSlider(){
        timelineSlider.minimumValue = 0
        timelineSlider.maximumValue = 100
        timelineSlider.tintColor = .white
//        timelineSlider.tintColor.withAlphaComponent(0.2)
        
        view.addSubview(timelineSlider)
        
        timelineSlider.snp.makeConstraints { make in
            make.top.equalTo(songInfoStack.snp.bottom)
                .offset(30)
            make.leading.equalTo(songInfoStack.snp.leading)
            make.trailing.equalTo(songSettingsStack.snp.trailing)
        }
    }
    
    private func setupCoverImageView(){
        view.addSubview(coverImageView)
        coverImageView.backgroundColor = .lightGray
        coverImageView.layer.cornerRadius = 15
        
        coverImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().labeled("X для облоги")
            make.centerY.equalToSuperview()
                .offset(-100).labeled("Y  для облоги")
            make.width.equalToSuperview().multipliedBy(0.85).labeled("ширина облоги")
            make.height.equalTo(coverImageView.snp.width).labeled("высота облоги")
    
        }
    }
    
    
    private func setupSongInfoStack() {
        songInfoStack = UIStackView(arrangedSubviews: [songNameLabel, artistNameLabel])
        songInfoStack.axis = .vertical
        songInfoStack.distribution = .fillProportionally
        songInfoStack.spacing = 8
        songInfoStack.alignment = .leading
        view.addSubview(songInfoStack)
        artistNameLabel.alpha = 0.7
        
//        songNameLabel.text = "Test&Test"
        songNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        artistNameLabel.text = "Test"
        
        songInfoStack.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }
    }

    private func setupSongSettingsStack() {
        songSettingsStack = UIStackView(arrangedSubviews: [shareButton, settingsButton])
        songSettingsStack.axis = .horizontal
        songSettingsStack.distribution = .fillProportionally
        songSettingsStack.spacing = 12
        
        shareButton.alpha = 0.7
        settingsButton.alpha = 0.7
        
        
        view.addSubview(songSettingsStack)
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        songSettingsStack.snp.makeConstraints { make in
            make.top.equalTo(songInfoStack.snp.top)
            make.leading.equalTo(songInfoStack.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    private func setupPlayerButtonsStack() {
        playerButtonsStack = UIStackView(arrangedSubviews: [backButton, playButton, nextButton])
        playerButtonsStack.axis = .horizontal
        playerButtonsStack.distribution = .fill
        playerButtonsStack.alignment = .center
        playerButtonsStack.spacing = 20
        
        playerButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerButtonsStack)
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(30).labeled("width back")
            make.height.equalTo(30).labeled("height back")
        }
                
        playButton.snp.makeConstraints { make in
            make.width.equalTo(70).labeled("width play")
            make.height.equalTo(70).labeled("height play")
        }
        
        playButton.imageView?.tintColor = .white
        nextButton.imageView?.tintColor = .white
        backButton.imageView?.tintColor = .white

        nextButton.snp.makeConstraints { make in
            make.width.equalTo(30).labeled("width forward")
            make.height.equalTo(30).labeled("height forward")
        }
        
        playerButtonsStack.snp.makeConstraints { make in
            make.top.equalTo(timelineSlider.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
}

//    override func viewWillDisappear(_ animated: Bool) {
//        <#code#>
//    }
