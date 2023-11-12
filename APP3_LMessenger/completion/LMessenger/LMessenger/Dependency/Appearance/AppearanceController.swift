//
//  AppearanceController.swift
//  LMessenger
//
//

import Foundation
import Combine

protocol AppearanceControllerable {
    var appearance: AppearanceType { get set }
    
    func changeAppearance(_ willBeAppearance: AppearanceType?)
}

class AppearanceController: AppearanceControllerable, ObservableObjectSettable {
    
    var objectWillChange: ObservableObjectPublisher?
    
    var appearance: AppearanceType = .automatic {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func changeAppearance(_ willBeAppearance: AppearanceType?) {
        appearance = willBeAppearance ?? .automatic
    }
}
