//
//  URLDefinition.swift
//  ServerSimulator
//

import Foundation

enum URLDefinition {
    static let liveThumbnailUrl: URL = .init(string: "http://localhost:8080/image/livethumb.png")!
    static let listThumbnailUrl: URL = .init(string: "http://localhost:8080/image/listthumb.png")!
    static let rankingThumbnailUrl: URL = .init(string: "http://localhost:8080/image/rankingthumbnail.png")!
    static let channelThumbnailUrl: URL = .init(string: "http://localhost:8080/image/user.png")!
    static func videoThumbnail(_ index: Int) -> URL {
        return .init(string: "http://localhost:8080/image/v_thumbnail\(index % 3 + 1).png")!
    }
    
    static func videoURL(_ index: Int) -> URL {
        switch index % 3 {
        case 0:
            return .init(string: "https://drive.google.com/uc?export=open&id=1zGekc8vLUYTEj-sY2ELKt1zYspBJHl8J")!
        case 1:
            return .init(string: "https://drive.google.com/uc?export=open&id=1T0EsaeOozI8hEUloGZYV0bsg2Mh_DF-_")!
        default:
            return .init(string: "https://drive.google.com/uc?export=open&id=1-p3rQojlhCS22Y3SM01N7lmI0xtxlMnE")!
        }
        
    }

}
