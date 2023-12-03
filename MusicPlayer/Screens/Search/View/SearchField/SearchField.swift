//
//
// MusicPlayer
// SearchField.swift
// 
// Created by Alexander Kist on 13.08.2023.
//


import UIKit

class SearchField: UITextField {
    
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSearchField()
    }
    
    private func setupSearchField() {
        searchIcon.tintColor = .darkGray
        searchIcon.contentMode = .scaleAspectFit
        leftView = searchIcon
        leftViewMode = .always
        placeholder = "Поиск"
        autocorrectionType = .no
        autocapitalizationType = .none
        returnKeyType = .search

    }
}
