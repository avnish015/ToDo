//
//  Observable.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import Foundation

final class Observable<T> {
    typealias Bind = (T)->Void
    
    var bind:Bind?
    
    var value:T {
        didSet {
            bind?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func observe(observer:Bind?) -> Void {
        self.bind = observer
    }
}
