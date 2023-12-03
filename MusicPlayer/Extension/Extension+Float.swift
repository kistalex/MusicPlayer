//
//
// MusicPlayer
// Extension+Float.swift
// 
// Created by Alexander Kist on 03.12.2023.
//


import Foundation

extension Float {
    func timeToString() -> String {
        let minute = Int(self) / 60
        let second = Int(self) % 60
        return String(format: "%02d:%02d", minute, second)
    }
}
