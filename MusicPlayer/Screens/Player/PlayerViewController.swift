//
//
// MusicPlayer
// PlayerViewController.swift
// 
// Created by Alexander Kist on 14.08.2023.
//


import UIKit
import SnapKit
import SDWebImage

class PlayerViewController: UIViewController {
    
    
    //MARK: - Properties
    private let coverImageView = UIImageView()
    
    private var timelineSlider = UISlider()
    
    private var songInfoView = SongInfoView()
    
    private var songSettingsView = SongSettingsView()
    
    private var playerButtonsView = PlayerButtonsView()
    
    private let viewModel: PlayerViewModel
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6698819399, blue: 0.6376078725, alpha: 1)
        setupUI()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupButtonAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.stopMusic()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    func configureUI(){
        songInfoView.artistNameLabel.text = viewModel.artistName
        songInfoView.songNameLabel.text = viewModel.trackName
        coverImageView.sd_setImage(with: viewModel.trackCover)
    }
    private func setupUI(){
        setupCoverImageView()
        setupSongInfoView()
        setupSongSettingsView()
        setupTimelineSlider()
        setupPlayerButtonsView()
    }
    
    private func setupTimelineSlider(){
        timelineSlider.minimumValue = 0
        timelineSlider.maximumValue = 100
        timelineSlider.tintColor = .white
        
        view.addSubview(timelineSlider)
        
        timelineSlider.snp.makeConstraints { make in
            make.top.equalTo(songInfoView.snp.bottom)
                .offset(30)
            make.leading.equalTo(songInfoView.snp.leading)
            make.trailing.equalTo(songSettingsView.snp.trailing)
        }
    }
    
    private func setupCoverImageView(){
        view.addSubview(coverImageView)
        coverImageView.backgroundColor = .lightGray
        coverImageView.layer.cornerRadius = 15
        
        coverImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
                .offset(-100)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(coverImageView.snp.width)
            
        }
    }
    
    private func setupSongInfoView() {
        view.addSubview(songInfoView)
        
        songInfoView.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }
    }
    
    private func setupSongSettingsView() {
        view.addSubview(songSettingsView)
        
        songSettingsView.snp.makeConstraints { make in
            make.top.equalTo(songInfoView.snp.top)
            make.leading.equalTo(songInfoView.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        
    }
    
    private func setupPlayerButtonsView() {
        view.addSubview(playerButtonsView)
        
        playerButtonsView.snp.makeConstraints { make in
            make.top.equalTo(timelineSlider.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupButtonAction(){
        playerButtonsView.backButtonAction = { [weak self] in
            self?.viewModel.playPreviousSong()
        }
        
        playerButtonsView.playButtonAction = { [weak self] in
            self?.viewModel.playSong()
        }
        playerButtonsView.forwardButtonAction = { [weak self] in
            self?.viewModel.playNextSong()
        }
    }
}


