//
//  HomeViewModel.swift
//  voiceMemo
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var selectedTab: Tab
  @Published var todosCount: Int
  @Published var memosCount: Int
  @Published var voiceRecordersCount: Int
  
  init(
    selectedTab: Tab = .voiceRecorder,
    todosCount: Int = 0,
    memosCount: Int = 0,
    voiceRecordersCount: Int = 0
  ) {
    self.selectedTab = selectedTab
    self.todosCount = todosCount
    self.memosCount = memosCount
    self.voiceRecordersCount = voiceRecordersCount
  }
}

extension HomeViewModel {
  func setTodosCount(_ count: Int) {
    todosCount = count
  }
  
  func setMemosCount(_ count: Int) {
    memosCount = count
  }
  
  func setVoiceRecordersCount(_ count: Int) {
    voiceRecordersCount = count
  }
  
  func changeSelectedTab(_ tab: Tab) {
    selectedTab = tab
  }
}
