//
//  SampleCache.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/05.
//

import Foundation
import UIKit
import Combine

class SampleCache {
    
    static let shared: SampleCache = .init()
    
    private var data: [Data] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {
        NotificationCenter.default.publisher(for: UIApplication.didReceiveMemoryWarningNotification)
            .sink { [weak self] _ in
                print("캐시 clear")
                self?.clear()
            }
            .store(in: &self.cancellables)
    }
    
    func add(data: Data) {
        self.data.append(data)
    }
    
    func clear() {
        self.data.removeAll()
    }
    
}
