//
//  Home.swift
//  ServerSimulator
//

import Foundation

struct Home: Encodable {
    
    let videos: [Video]
    let rankings: [Ranking]
    let recents: [Recent]
    let recommends: [ListItem]
    
    static func make() -> Home {
        .init(
            videos: [
                .init(
                    videoId: 1,
                    isHot: true,
                    title: "첫번째 동영상",
                    subtitle: "첫번째 부제목",
                    channel: "첫번째 채널",
                    channelDescription: "이런저런 채널"
                ),
                .init(
                    videoId: 2,
                    isHot: false,
                    title: "두번째 동영상",
                    subtitle: "두번째 부제목",
                    channel: "첫번째 채널",
                    channelDescription: "이런저런 채널"
                )
            ],
            rankings: [
                .init(videoId: 3),
                .init(videoId: 4),
                .init(videoId: 5),
                .init(videoId: 6),
                .init(videoId: 7)
            ],
            recents: [
                .init(
                    videoId: 1,
                    timeStamp: Date().timeIntervalSince1970,
                    title: "첫번째 동영상",
                    channel: "첫번째 채널"
                ),
                .init(
                    videoId: 1,
                    timeStamp: Date().timeIntervalSince1970,
                    title: "두번째 동영상",
                    channel: "두번째 채널"
                )
            ],
            recommends: [
                .init(videoId: 1, title: "첫번째 추천", playtime: 90, channel: "추천 채널"),
                .init(videoId: 2, title: "두번째 추천", playtime: 70, channel: "추천 채널"),
                .init(videoId: 3, title: "세번째 추천", playtime: 100, channel: "추천 채널"),
                .init(videoId: 4, title: "네번째 추천", playtime: 90, channel: "추천 채널"),
                .init(videoId: 5, title: "다섯번째 추천", playtime: 30, channel: "추천 채널"),
                .init(videoId: 6, title: "여섯번째 추천", playtime: 40, channel: "추천 채널"),
                .init(videoId: 7, title: "일곱번째 추천", playtime: 60, channel: "추천 채널"),
                .init(videoId: 8, title: "여덟번째 추천", playtime: 40, channel: "추천 채널"),
                .init(videoId: 9, title: "아홉번째 추천", playtime: 60, channel: "추천 채널")
            ]
        )
    }
}

extension Home {
    
    struct Video: Encodable {
        let videoId: Int
        let isHot: Bool
        let title: String
        let subtitle: String
        let imageUrl: URL
        let channel: String
        let channelThumbnailURL: URL
        let channelDescription: String
        
        internal init(
            videoId: Int,
            isHot: Bool,
            title: String,
            subtitle: String,
            channel: String,
            channelDescription: String
        ) {
            self.videoId = videoId
            self.isHot = isHot
            self.title = title
            self.subtitle = subtitle
            self.imageUrl = URLDefinition.videoThumbnail(videoId % 3 + 1)
            self.channel = channel
            self.channelThumbnailURL = URLDefinition.channelThumbnailUrl
            self.channelDescription = channelDescription
        }
    }
    
    struct Ranking: Encodable {
        let imageUrl: URL
        let videoId: Int
        
        init(videoId: Int) {
            self.imageUrl = URLDefinition.rankingThumbnailUrl
            self.videoId = videoId
        }
    }
    
    struct Recent: Encodable {
        let videoId: Int
        let imageUrl: URL
        let timeStamp: Double
        let title: String
        let channel: String
        
        init(videoId: Int, timeStamp: Double, title: String, channel: String) {
            self.imageUrl = URLDefinition.videoThumbnail(videoId)
            self.timeStamp = timeStamp
            self.title = title
            self.channel = channel
            self.videoId = videoId
        }
    }
}

