//
//  Live.swift
//  KTV
//
//  Created by Lecture on 2023/09/16.
//

import Foundation


struct Live: Decodable {
    let list: [Item]
}

extension Live {
    struct Item: Decodable {
        let videoId: Int
        let thumbnailUrl: URL
        let title: String
        let channel: String
    }
}

