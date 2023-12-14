//
//  AModule.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/04.
//

import Foundation
import UIKit
import Combine

class AModule {
    
    private let dummy = DummyGenerator.make()
    var bModule: BModule?
    
//    deinit {
//        print("AModule deinit")
//    }
}

class BModule {
    
    var aModule: AModule
//    weak var aModule: AModule?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(aModule: AModule) {
        self.aModule = aModule
        self.aModule.bModule = self
//        self.aModule?.bModule = self
        
        NotificationCenter.default.publisher(for: UIApplication.didReceiveMemoryWarningNotification)
            .sink { _ in
                print("memory warning catch in BModule")
            }
            .store(in: &self.cancellables)
    }
    
//    deinit {
//        print("BModule deinit")
//    }
}

class CircularA {
    private let dummy = DummyGenerator.make()
    var b: CircularB?
    
//    deinit {
//        print("circularA deinit")
//    }
}

class CircularB {
    var c: CircularC?
    
//    deinit {
//        print("circularB deinit")
//    }
}

class CircularC {
    var a: CircularA?
//    weak var a: CircularA?
    
//    deinit {
//        print("circularC deinit")
//    }
}
