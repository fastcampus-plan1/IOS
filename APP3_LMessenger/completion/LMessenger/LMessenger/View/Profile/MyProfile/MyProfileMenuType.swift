//
//  MyProfileMenuType.swift
//  LMessenger
//
//

import Foundation

enum MyProfileMenuType: Hashable, CaseIterable {
    case studio
    case decorate
    case keep
    case story
    
    var description: String {
        switch self {
        case .studio:
            return "스튜디오"
        case .decorate:
            return "꾸미기"
        case .keep:
            return "Keep"
        case .story:
            return "스토리"
        }
    }
    
    var imageName: String {
        switch self {
        case .studio:
            return "mood"
        case .decorate:
            return "palette"
        case .keep:
            return "bookmark_profile"
        case .story:
            return "play_circle"
        }
    }
}

