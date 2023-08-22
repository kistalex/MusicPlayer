//
//
// MusicPlayer
// ViewController.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        title = ""
        setupUI()
    }
    
    //MARK: - Private properties
    
    private enum Constants{
        static let viewHorizontalPadding: CGFloat = 16
        static let searchFieldTopPadding: CGFloat = 10
        static let songsTableViewTopPadding: CGFloat = 20
    }
    
    private var searchField = SearchField()
    
    private var songsTableView = UITableView()
    
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
    }
}

//MARK: - Extensions
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songsInfo?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongCell.self)", for: indexPath) as? SongCell else {
            fatalError("TableView couldn't dequeue a SongCell")
        }
        if let songs = viewModel.songsInfo?.results[indexPath.item]{
            cell.configure(with: songs)
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        songsTableView.deselectRow(at: indexPath, animated: true)
        let playerVC = PlayerViewController()
        if let songs = viewModel.songsInfo?.results[indexPath.item]{
            playerVC.configure(with: songs)
        }
        self.navigationController?.pushViewController(playerVC, animated: true)
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

extension SearchViewController: SearchViewModelDelegate {
    func dataDidLoad() {
        self.songsTableView.reloadData()
    }
}
