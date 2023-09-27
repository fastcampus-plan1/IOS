//
//  voiceMemoApp.swift
//  voiceMemo
//

import SwiftUI

@main
struct voiceMemoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      OnboardingView()
    }
  }
}
