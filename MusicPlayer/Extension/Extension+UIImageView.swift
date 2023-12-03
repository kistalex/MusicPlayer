//
//
// MusicPlayer
// Extension+UIImage.swift
// 
// Created by Alexander Kist on 18.08.2023.
//


import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode, tintColor: UIColor? = nil) {
        self.init()
        self.image = image
        self.contentMode = contentMode
        self.tintColor = tintColor
    }
}

