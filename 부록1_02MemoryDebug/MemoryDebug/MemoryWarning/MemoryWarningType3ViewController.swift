//
//  MemoryWarningType3ViewController.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/04.
//

import UIKit
import Combine

class MemoryWarningType3ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private var voidClosure: (() -> Void)?
    
//    deinit {
//        print("MemoryWarningType3ViewController deinit")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.bind()
    }
    
    private func bind() {
        self.viewModel.dataChangePublisher.sink {
            self.logSomething()
        }.store(in: &self.cancellables)
        
        self.voidClosure = {
            self.logSomething()
        }
        
//        self.viewModel.dataChangePublisher.sink { [weak self] in
//            self?.logSomething()
//        }.store(in: &self.cancellables)
//
//        self.voidClosure = { [weak self] in
//            self?.logSomething()
//        }
    }
    
    private func logSomething() {
        
    }
    
    private class ChildView: UIView {
    }

}

fileprivate class ViewModel {
    
    private let data = DummyGenerator.make()
    let dataChangePublisher: any Publisher<Void, Never> = PassthroughSubject()
}
