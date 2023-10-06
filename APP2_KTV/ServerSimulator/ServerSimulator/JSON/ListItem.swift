//
//  ListItem.swift
//  ServerSimulator
//

import Foundation

struct ListItem: Codable {
    let videoId: Int
    let imageUrl: URL
    let title: String
    let playtime: Double
    let channel: String
    
    init(videoId: Int, title: String, playtime: Double, channel: String) {
        self.videoId = videoId
        self.imageUrl = URLDefinition.listThumbnailUrl
        self.title = title
        self.playtime = playtime
        self.channel = channel
    }
}
