//
//
// MusicPlayer
// Observable.swift
// 
// Created by Alexander Kist on 30.08.2023.
//


import Foundation

class Observable<T> {
    var value: T?{
        didSet{
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping ((T?) -> Void)){
        listener(value)
        self.listener = listener
    }
}
