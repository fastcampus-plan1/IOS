//
//  WeakSample.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/05.
//

import Foundation

class WeakMain {
    
    weak var sub: WeakSub?
}

class WeakSub {
    
    let value: Int = 1
}
