//
//  My.swift
//  ServerSimulator
//

import Foundation

struct Bookmark: Encodable {
    let channels: [Item]
    
    static func make() -> Bookmark {
        .init(channels: [
            .init(channel: "채널1", channelId: 1),
            .init(channel: "채널1", channelId: 2),
            .init(channel: "채널2", channelId: 3)
        ])
    }
}

extension Bookmark {

    struct Item: Codable {
        let channel: String
        let channelId: Int
        let thumbnail: URL
        
        init(channel: String, channelId: Int) {
            self.channel = channel
            self.channelId = channelId
            self.thumbnail = URLDefinition.channelThumbnailUrl
        }
    }
}

struct Favorite: Encodable {
    let list: [ListItem]
    
    static func make() -> Favorite {
        .init(
            list: [
                .init(videoId: 1, title: "첫번째 좋아요 한 영상", playtime: 90, channel: "좋아요 채널 1"),
                .init(videoId: 2, title: "두번째 좋아요 한 영상", playtime: 70, channel: "좋아요 채널 2"),
                .init(videoId: 3, title: "세번째 좋아요 한 영상", playtime: 100, channel: "좋아요 채널 3"),
                .init(videoId: 4, title: "네번째 좋아요 한 영상", playtime: 90, channel: "좋아요 채널 4"),
                .init(videoId: 5, title: "다섯번째 좋아요 한 영상", playtime: 30, channel: "좋아요 채널 5"),
                .init(videoId: 6, title: "여섯번째 좋아요 한 영상", playtime: 40, channel: "좋아요 채널 6"),
                .init(videoId: 7, title: "일곱번째 좋아요 한 영상", playtime: 60, channel: "좋아요 채널 7"),
                .init(videoId: 8, title: "여덟번째 좋아요 한 영상", playtime: 40, channel: "좋아요 채널 8"),
                .init(videoId: 9, title: "아홉번째 좋아요 한 영상", playtime: 60, channel: "좋아요 채널 9")
            ]
        )
    }
}
