//
//  DataSetter.swift
//  Task
//
//  Created by Lecture on 2023/09/12.
//

import Foundation

actor Counter {
//class Counter {
    
    private var value: Int = 0
    
    func increment() -> Int {
        self.value += 1
        return self.value
    }
    
    nonisolated func printText() {
        
        print("non isolated method")
    }
}
