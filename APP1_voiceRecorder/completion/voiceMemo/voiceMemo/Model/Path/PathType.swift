//
//  PathType.swift
//  voiceMemo
//

enum PathType: Hashable {
  case homeView
  case todoView
  case memoView(isCreatMode: Bool, memo: Memo?)
}
