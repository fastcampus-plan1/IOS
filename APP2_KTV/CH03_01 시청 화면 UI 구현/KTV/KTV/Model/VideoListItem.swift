//
//  VideoListItem.swift
//  KTV
//
//  Created by Lecture on 2023/09/11.
//

import Foundation

struct VideoListItem: Decodable {
    let imageUrl: URL
    let title: String
    let playtime: Double
    let channel: String
    let videoId: Int
}
