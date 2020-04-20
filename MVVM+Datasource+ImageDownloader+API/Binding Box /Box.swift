//
//  Box.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import Foundation
class Box<T> {
    
    private var bindHandler:((T) -> ())?
    var value:T{
        didSet{
            bindHandler?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(_ listener:((T) -> ())?)  {
        self.bindHandler = listener
        listener?(value)
    }
}
