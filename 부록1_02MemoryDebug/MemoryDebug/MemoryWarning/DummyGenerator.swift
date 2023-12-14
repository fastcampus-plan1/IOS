//
//  DummyGenerator.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/04.
//

import Foundation

enum DummyGenerator {
    
    static func make() -> Data {
        Data(repeating: 1, count: 2 * 100 * 1024 * 1024)
    }
}
