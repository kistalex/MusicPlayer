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
    
    var isLoading: Observable<Bool> = Observable(value: false)

    //MARK: - Private properties
    private var apiManager = ApiManager()
    
    //MARK: - Properties
    var songsInfo: SearchResult?
    var songs: Observable<[SongCellViewModel]> = Observable(value: nil)
    weak var delegate: SearchViewModelDelegate?
    
    //MARK: - Methods
    func fetchSongsFromApi(with text: String){
        if isLoading.value ?? true{
            return
        }
        apiManager.fetchDataFromAPI(with: text) { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async {
                    self?.songsInfo = responseData
                    self?.mapSongCellData()
                }
            case .failure(let error):
                print("Ошибка чтения json: \(error)")
            }}
    }
    
    func numberOrRows() -> Int {
        return self.songsInfo?.results.count ?? 0
    }
    
    func getSongInfo(index: Int) -> SongInfo? {
        return self.songsInfo?.results[index]
    }
    
    func mapSongCellData(){
       songs.value = self.songsInfo?.results.compactMap({SongCellViewModel(song: $0)})
    }
    
    func retrieveSong(withId id: Int) -> SongInfo?{
        guard let song = songsInfo?.results.first(where: {$0.trackID == id}) else {
            return nil
        }
        return song
    }
    
    func retrieveSongs() -> [SongInfo]?{
        guard let songs = songsInfo?.results else {
            return nil
        }
        return songs
    }
}
