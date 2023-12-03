//
//
// MusicPlayer
// ViewController.swift
//
// Created by Alexander Kist on 13.08.2023.
//


import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = ""
        setupUI()
        bindViewModel()
    }
    
    //MARK: - Private properties
    
    private enum Constants{
        static let viewHorizontalPadding: CGFloat = 16
        static let searchFieldTopPadding: CGFloat = 10
        static let songsTableViewTopPadding: CGFloat = 20
    }
    
    private var searchField = SearchField()
    
    private var songsTableView = UITableView()
    private var activityIndicator = UIActivityIndicatorView()
    private var songCellDataSource: [SongCellViewModel] = []
    
    private let viewModel = SearchViewModel()
    
    //MARK: - Private methods
    private func setupUI(){
        setupSearchField()
        setupTableView()
    }
    
    private func setupSearchField(){
        view.addSubview(searchField)
        searchField.delegate = self
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.searchFieldTopPadding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constants.viewHorizontalPadding)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constants.viewHorizontalPadding)
        }
    }
    
    private func setupTableView(){
        songsTableView.register(SongCell.self, forCellReuseIdentifier: "\(SongCell.self)")
        view.addSubview(songsTableView)
        
        songsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(Constants.songsTableViewTopPadding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constants.viewHorizontalPadding)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constants.viewHorizontalPadding)
            make.bottom.equalTo(view.snp.bottom)
        }
        songsTableView.delegate = self
        songsTableView.dataSource = self
    }
    
    private func bindViewModel(){

        viewModel.songs.bind { [weak self] songs  in
            guard let self = self, let songs = songs else {
                return
            }
            self.songCellDataSource = songs
            self.reloadTableView()
        }
    }
    
    private func openPlayer(songId: Int, currentIndex: Int){
        guard let songs = viewModel.retrieveSongs() else {
            return
        }
        let playerViewModel = PlayerViewModel(songs: songs, startIndex: currentIndex)
        let playerViewController = PlayerViewController(viewModel: playerViewModel)
        
            self.navigationController?.pushViewController(playerViewController, animated: true)
        
    }
}

//MARK: - Extensions
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOrRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongCell.self)", for: indexPath) as? SongCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: songCellDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.songsTableView.reloadData()
        }
    }
}


extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        songsTableView.deselectRow(at: indexPath, animated: true)
        let songId = songCellDataSource[indexPath.row].id
        self.openPlayer(songId: songId, currentIndex: indexPath.row)
        
    }
}

extension SearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        if let searchText = searchField.text, searchText.count >= 3 {
            viewModel.fetchSongsFromApi(with: searchText)
        }
        return true
    }
}
