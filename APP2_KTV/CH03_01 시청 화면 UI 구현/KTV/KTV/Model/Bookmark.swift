//
//  Bookmark.swift
//  KTV
//
//  Created by Lecture on 2023/09/10.
//

import Foundation

struct Bookmark: Decodable {
    
    let channels: [Item]
}

extension Bookmark {
    
    struct Item: Decodable {
        let channel: String
        let channelId: Int
        let thumbnail: URL
    }
}
