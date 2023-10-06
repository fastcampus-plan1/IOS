//
//  Live.swift
//  ServerSimulator
//

import Foundation

struct Live: Codable {
    let list: [Item]
    
    static func make(sortByPopular: Bool) -> Live {
        let list: [Item] = [
            .init(videoId: 1, title: "첫번째 라이브 진행중", channel: "채널1"),
            .init(videoId: 2, title: "두번째 라이브 진행중", channel: "채널2"),
            .init(videoId: 3, title: "세번째 라이브 진행중", channel: "채널3"),
            .init(videoId: 4, title: "네번째 라이브 진행중", channel: "채널4"),
            .init(videoId: 5, title: "다섯번째 라이브 진행중", channel: "채널5"),
            .init(videoId: 6, title: "여섯번째 라이브 진행중", channel: "채널6"),
            .init(videoId: 7, title: "일곱번째 라이브 진행중", channel: "채널7"),
            .init(videoId: 8, title: "여덟번째 라이브 진행중", channel: "채널8"),
            .init(videoId: 9, title: "아홉번째 라이브 진행중", channel: "채널9"),
            .init(videoId: 10, title: "열번째 라이브 진행중", channel: "채널10"),
            .init(videoId: 11, title: "열한번째 라이브 진행중", channel: "채널11"),
            .init(videoId: 12, title: "열두번째 라이브 진행중", channel: "채널12"),
            .init(videoId: 13, title: "열세번째 라이브 진행중", channel: "채널13"),
            .init(videoId: 14, title: "열네번째 라이브 진행중", channel: "채널14"),
            .init(videoId: 15, title: "열다섯번째 라이브 진행중", channel: "채널15"),
            .init(videoId: 16, title: "열여섯번째 라이브 진행중", channel: "채널16"),
            .init(videoId: 17, title: "열일곱번째 라이브 진행중", channel: "채널17"),
            .init(videoId: 18, title: "열여덟번째 라이브 진행중", channel: "채널18")
        ]
        
        if sortByPopular {
            return .init(list: list)
        } else {
            return .init(list: list.reversed())
        }
    }
}

extension Live {
    struct Item: Codable {
        let videoId: Int
        let thumbnailUrl: URL
        let title: String
        let channel: String
        
        init(videoId: Int, title: String, channel: String) {
            self.videoId = videoId
            self.thumbnailUrl = URLDefinition.liveThumbnailUrl
            self.title = title
            self.channel = channel
        }
    }
}

