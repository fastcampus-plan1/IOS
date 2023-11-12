//
//  AppearanceType.swift
//  LMessenger
//
//

import SwiftUI

enum AppearanceType: Int, CaseIterable, SettingItemable {
    case automatic
    case light
    case dark
    
    var label: String {
        switch self {
        case .automatic:
            return "시스템모드"
        case .light:
            return "라이트모드"
        case .dark:
            return "다크모드"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .automatic:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
