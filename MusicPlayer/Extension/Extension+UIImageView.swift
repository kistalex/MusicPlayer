//
//
// MusicPlayer
// Extension+UIImage.swift
// 
// Created by Alexander Kist on 18.08.2023.
//


import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, tintColor: UIColor? = nil, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.tintColor = tintColor
        self.contentMode = contentMode
    }
}
