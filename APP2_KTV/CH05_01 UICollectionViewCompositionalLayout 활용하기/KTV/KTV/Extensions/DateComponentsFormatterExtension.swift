//
//  DateComponentsFormatterExtension.swift
//  KTV
//
//  Created by Lecture on 2023/09/21.
//

import Foundation

extension DateComponentsFormatter {
    
    static let playTimeFormatter: DateComponentsFormatter = {
       let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }()
}
