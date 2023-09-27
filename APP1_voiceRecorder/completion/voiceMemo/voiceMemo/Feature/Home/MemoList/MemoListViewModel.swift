//
//  MemoListViewModel.swift
//  voiceMemo
//

import Foundation

class MemoListViewModel: ObservableObject {
  @Published var memos: [Memo]
  @Published var isEditMemoMode: Bool
  @Published var removeMemos: [Memo]
  @Published var isDisplayRemoveMemoAlert: Bool
  
  var removeMemoCount: Int {
    return removeMemos.count
  }
  var navigationBarRightBtnMode: NavigationBtnType {
    isEditMemoMode ? .complete : .edit
  }
  
  init(
    memos: [Memo] = [],
    isEditMemoMode: Bool = false,
    removeMemos: [Memo] = [],
    isDisplayRemoveMemoAlert: Bool = false
  ) {
    self.memos = memos
    self.isEditMemoMode = isEditMemoMode
    self.removeMemos = removeMemos
    self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
  }
}

extension MemoListViewModel {
  func addMemo(_ memo: Memo) {
    memos.append(memo)
  }
  
  func updateMemo(_ memo: Memo) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
      memos[index] = memo
    }
  }
  
  func removeMemo(_ memo: Memo) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
      memos.remove(at: index)
    }
  }
  
  func navigationRightBtnTapped() {
    if isEditMemoMode {
      if removeMemos.isEmpty {
        isEditMemoMode = false
      } else {
        setIsDisplayRemoveMemoAlert(true)
      }
    } else {
      isEditMemoMode = true
    }
  }
  
  func setIsDisplayRemoveMemoAlert(_ isDisplay: Bool) {
    isDisplayRemoveMemoAlert = isDisplay
  }
  
  func memoRemoveSelectedBoxTapped(_ memo: Memo) {
    if let index = removeMemos.firstIndex(of: memo) {
      removeMemos.remove(at: index)
    } else {
      removeMemos.append(memo)
    }
  }
  
  func removeBtnTapped() {
    memos.removeAll { memo in
      removeMemos.contains(memo)
    }
    removeMemos.removeAll()
    isEditMemoMode = false
  }
}
