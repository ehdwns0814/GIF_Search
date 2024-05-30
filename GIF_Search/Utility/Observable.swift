//
//  Observable.swift
//  GIF_Search
//
//  Created by 동준 on 5/27/24.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T?) -> Void
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    private var listener: Listener?
    
    func bind(_ listener: @escaping Listener) {
        listener(value)
        self.listener = listener
    }
}
