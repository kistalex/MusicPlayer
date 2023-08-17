//
//
// MusicPlayer
// SearchViewModel.swift
// 
// Created by Alexander Kist on 17.08.2023.
//


import Foundation


protocol SearchViewModelDelegate: AnyObject {
    func dataDidLoad()
}

class SearchViewModel {

    //MARK: - Private properties
    private var apiManager = ApiManager()
    
    //MARK: - Properties
    var songsInfo: SearchResult?
    weak var delegate: SearchViewModelDelegate?
    
    //MARK: - Methods
    func fetchSongsFromApi(with text: String){
        apiManager.fetchDataFromAPI(with: text) { result in
            switch result {
            case .success(let responseData):
                self.songsInfo = responseData
                DispatchQueue.main.async {
                    self.delegate?.dataDidLoad()
                }
            case .failure(let error):
                print("Ошибка чтения json: \(error)")
            }}
    }
}
