//
//  BookmarkViewModel.swift
//  KTV
//
//  Created by Lecture on 2023/09/10.
//

import Foundation

@MainActor class BookmarkViewModel {
    
    private(set) var channels: [Bookmark.Item]?
    var dataChanged: (() -> Void)?
    
    func request() {
        Task {
            do {
                let data = try await DataLoader.load(url: URLDefines.bookmark, for: Bookmark.self)
                self.channels = data.channels
                self.dataChanged?()
            } catch {
                print("bookmark list load failed: \(error.localizedDescription)")
            }
            
        }
    }
}
