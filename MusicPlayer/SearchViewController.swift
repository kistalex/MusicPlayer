//
//
// MusicPlayer
// ViewController.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit

class SearchViewController: UIViewController {
    
    private var searchField = SearchField()
    private var songsTableView: UITableView!
    private var dataService = DataService()
    private var songInfo: Response?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Поиск"
        fetchBannerData(forFileName: "response")
        setupUI()
    }
    
    private func setupUI(){
        setupSearchField()
        setupTableView()
    }
    
    private func fetchBannerData(forFileName fileName: String){
        dataService.fetchBannerData(fromFileNamed: fileName) { [weak self] result  in
            switch result{
            case .success(let songInfo):
                self?.songInfo = songInfo
                
            case .failure(let error):
                print("Ошибка чтения json: \(error)")
            }
        }
    }
    
    private func setupSearchField(){
        searchField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchField)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupTableView(){
        songsTableView = UITableView(frame: view.bounds)
        songsTableView.register(SongCell.self, forCellReuseIdentifier: "\(SongCell.self)")
        songsTableView.rowHeight = UITableView.automaticDimension
        songsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songsTableView)
        
        NSLayoutConstraint.activate([
            songsTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30),
            songsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            songsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            songsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
//        songsTableView.delegate = self
        songsTableView.dataSource = self
    }
    
}




extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongCell.self)", for: indexPath) as? SongCell else {
            fatalError("TableView couldn't dequeue a SongCell")
        }
        if let dataResult = songInfo?.results[indexPath.item]{
            cell.configure(with: dataResult)
        }
        return cell
    }
}

//extension ViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//}
    
