//
//
// MusicPlayer
// ViewController.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Поиск"
        viewModel.delegate = self
        setupUI()
    }
    
    //MARK: - Private properties
    
    private enum Constants{
        static let viewHorizontalPadding: CGFloat = 16
        static let searchFieldTopPadding: CGFloat = 10
        static let songsTableViewTopPadding: CGFloat = 20
    }
    
    private var searchField = SearchField()
    private var songsTableView: UITableView!
    private let viewModel = SearchViewModel()
    
    //MARK: - Private methods
    private func setupUI(){
        setupSearchField()
        setupTableView()
    }
    
    private func setupSearchField(){
        searchField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchField)
        searchField.delegate = self
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.searchFieldTopPadding),
            searchField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.viewHorizontalPadding),
            searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.viewHorizontalPadding),
        ])
        
    }
    
    private func setupTableView(){
        songsTableView = UITableView()
        songsTableView.register(SongCell.self, forCellReuseIdentifier: "\(SongCell.self)")
        songsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songsTableView)
        
        NSLayoutConstraint.activate([
            songsTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: Constants.songsTableViewTopPadding),
            songsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.viewHorizontalPadding),
            songsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.viewHorizontalPadding),
            songsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
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
