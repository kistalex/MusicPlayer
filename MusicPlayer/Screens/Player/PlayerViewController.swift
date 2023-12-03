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
    
    //MARK: - Private properties
    private let coverImageView = UIImageView()
    
    private var timelineSlider = UISlider()
    
    private var songInfoView = SongInfoView()
    
    private var songSettingsView = SongSettingsView()
    
    private var playerButtonsView = PlayerButtonsView()
    
    private let viewModel: PlayerViewModel
    
    private var elapsedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "0:00"
        label.textColor = .label
        return label
    }()

    private var remainingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "0:00"
        label.textColor = .label
        return label
    }()

    private enum Constants {
        static let backgroundColor: UIColor = .systemBackground
    }
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        setupUI()
        viewModel.delegate = self
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupButtonAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopMusic()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        coverImageView.layer.cornerRadius = 10
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    private func configureUI(){
        coverImageView.sd_setImage(with: viewModel.trackCover)
        songInfoView.viewModel = viewModel
    }
    private func setupUI(){
        setupCoverImageView()
        setupSongInfoView()
        setupSongSettingsView()
        setupTimelineSlider()
        setupTimelineLabels()
        setupPlayerButtonsView()
        setupViewModel()
    }
    
    private func setupCoverImageView(){
        view.addSubview(coverImageView)
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
        songInfoView.viewModel = viewModel
        
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
        
        timelineSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

    private func setupTimelineLabels() {
        view.addSubview(elapsedLabel)
        elapsedLabel.snp.makeConstraints { make in
            make.top.equalTo(timelineSlider.snp.bottom).offset(20)
            make.leading.equalTo(timelineSlider.snp.leading)
        }

        view.addSubview(remainingLabel)
        remainingLabel.snp.makeConstraints { make in
            make.top.equalTo(timelineSlider.snp.bottom).offset(20)
            make.trailing.equalTo(timelineSlider.snp.trailing)
        }
    }

    @objc private func sliderValueChanged() {
        viewModel.seek(to: timelineSlider.value)
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
            self?.viewModel.playSong(at: self?.viewModel.id)
        }
        playerButtonsView.forwardButtonAction = { [weak self] in
            self?.viewModel.playNextSong()
        }
    }
    
    private func setupViewModel(){
        viewModel.onPlayNextSong = { [weak self] isEnabled in
            DispatchQueue.main.async {
                self?.playerButtonsView.forwardButton.isEnabled = isEnabled
            }
            
        }
        
        viewModel.onPlayPreviousSong = {[weak self] isEnabled in
            DispatchQueue.main.async {
                self?.playerButtonsView.backwardButton.isEnabled = isEnabled
            }
            
        }
        
        viewModel.onPlayPauseSong = {[weak self] isPlaying in
            DispatchQueue.main.async {
                let buttonImageName = isPlaying ? "circle.fill.play" : "circle.fill.pause"
                self?.playerButtonsView.playButton.setImage(UIImage(named: buttonImageName), for: .normal)
            }
        }
        
        viewModel.onPlaybackTimeChange = { [weak self] time in
            DispatchQueue.main.async {
                self?.timelineSlider.value = time
                self?.elapsedLabel.text = time.timeToString()

                if let duration = self?.timelineSlider.maximumValue {
                    let remainingTime = duration - time
                    self?.remainingLabel.text = "-" + (remainingTime.timeToString())
                }
            }
        }

        viewModel.onDurationChange = { [weak self] duration in
            self?.timelineSlider.maximumValue = duration
        }
    }
}


extension PlayerViewController: PlayerViewModelDelegate{
    func trackDidUpdate(_ viewModel: PlayerViewModel, track: SongInfo) {
        configureUI()
    }
}
