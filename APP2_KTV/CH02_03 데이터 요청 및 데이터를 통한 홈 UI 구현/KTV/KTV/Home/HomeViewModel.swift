//
//  HomeViewModel.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import Foundation

@MainActor class HomeViewModel {
    
    private(set) var home: Home?
    var dataChanged: (() -> Void)?
    
    func requestData() {
        Task {
            do {
                self.home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
                self.dataChanged?()
            } catch {
                print("json parsing failed: \(error.localizedDescription)")
            }
        }
    }
}
