//
//
// MusicPlayer
// Extension+UIButton.swift
// 
// Created by Alexander Kist on 20.08.2023.
//


import Foundation
import UIKit

extension UIButton {
    convenience init(icon: UIImage?,tintColor: UIColor? = .black,imageInsets: UIEdgeInsets = .zero, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .custom)
        self.tintColor = tintColor
        setImage(icon, for: .normal)
        addTarget(target, action: action!, for: .touchUpInside)
    }
}
