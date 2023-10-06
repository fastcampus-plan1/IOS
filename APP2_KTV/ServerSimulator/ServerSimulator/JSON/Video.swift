//
//  Video.swift
//  ServerSimulator
//

import Foundation

struct Video: Encodable {
    
    let videoId: Int
    let videoURL: URL
    let title: String
    let uploadTimestamp: TimeInterval
    let playCount: Int
    let favoriteCount: Int
    let channelImageUrl: URL
    let channel: String
    let channelId: Int
    let recommends: [ListItem]
    
    static func make() -> Video {
        .init(
            videoId: 1,
            videoURL: URLDefinition.videoURL(1),
            title: "[Lorem ips] Lorem ipsum dolor sit amet,  con",
            uploadTimestamp: Date().timeIntervalSince1970,
            playCount: 10,
            favoriteCount: 3,
            channelImageUrl: URLDefinition.channelThumbnailUrl,
            channel: "Lorem Ipsum is simply dummy text of the print",
            channelId: 1,
            recommends: [
                .init(videoId: 1, title: "첫번째 추천", playtime: 90, channel: "추천 채널"),
                .init(videoId: 2, title: "두번째 추천", playtime: 70, channel: "추천 채널"),
                .init(videoId: 3, title: "세번째 추천", playtime: 100, channel: "추천 채널"),
                .init(videoId: 4, title: "네번째 추천", playtime: 90, channel: "추천 채널"),
                .init(videoId: 5, title: "다섯번째 추천", playtime: 30, channel: "추천 채널"),
                .init(videoId: 6, title: "여섯번째 추천", playtime: 40, channel: "추천 채널"),
                .init(videoId: 7, title: "일곱번째 추천", playtime: 60, channel: "추천 채널"),
                .init(videoId: 8, title: "여덟번째 추천", playtime: 40, channel: "추천 채널"),
                .init(videoId: 9, title: "아홉번째 추천", playtime: 60, channel: "추천 채널"),
            ]
        )
    }
}
