//
//  UnownedSample.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/05.
//

import Foundation

class UnownedMain {
    
    unowned var sub: UnownedSub
    init(sub: UnownedSub) {
        self.sub = sub
    }
}

class UnownedSub {
    
    let value: Int = 1
}

class UnownedOptionalMain {
    
    unowned var sub: UnownedOptionalSub?
}

class UnownedOptionalSub {
    
    let value: Int = 1
}
