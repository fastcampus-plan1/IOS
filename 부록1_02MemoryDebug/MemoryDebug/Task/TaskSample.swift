//
//  TaskSample.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/05.
//

import Foundation

class TaskSample {
    
    func doSomething() {
//        Task {
//            do {
//                try await self.getSomething()
//                self.printSomething()
//                print("finished")
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
        
        Task { [weak self] in
            do {
                try await self?.getSomething()
                self?.printSomething()  // 이 경우 getSomething이 끝나기전에 TaskSample 인스턴스가 사라지면 printSomething이 불리지 않게됨.
                print("finished")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getSomething() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000 * 10)
    }
    
    private func printSomething() {
        print("job finished")
    }
}
