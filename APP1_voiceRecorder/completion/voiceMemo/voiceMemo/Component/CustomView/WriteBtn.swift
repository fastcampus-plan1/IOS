//
//  WriteBtn.swift
//  voiceMemo
//
//

import SwiftUI

// MARK: - 1️⃣
public struct WriteBtnViewModifier: ViewModifier {
  let action: () -> Void
  
  public init(action: @escaping () -> Void) {
    self.action = action
  }
  
  public func body(content: Content) -> some View {
    ZStack {
      content
      
      VStack {
        Spacer()
        
        HStack {
          Spacer()
          
          Button(
            action: action,
            label: { Image("writeBtn") }
          )
        }
      }
      .padding(.trailing, 20)
      .padding(.bottom, 50)
    }
  }
}

// MARK: - 2️⃣
extension View {
  public func writeBtn(perform action: @escaping () -> Void) -> some View {
    ZStack {
      self
      
      VStack {
        Spacer()
        
        HStack {
          Spacer()
          
          Button(
            action: action,
            label: { Image("writeBtn") }
          )
        }
      }
      .padding(.trailing, 20)
      .padding(.bottom, 50)
    }
  }
}

// MARK: - 3️⃣
public struct WriteBtnView<Content: View>: View {
  let content: Content
  let action: () -> Void
  
  public init(
    @ViewBuilder content: () -> Content,
    action: @escaping () -> Void
  ) {
    self.content = content()
    self.action = action
  }
  
  public var body: some View {
    ZStack {
      content
      
      VStack {
        Spacer()
        
        HStack {
          Spacer()
          
          Button(
            action: action,
            label: { Image("writeBtn") }
          )
        }
      }
      .padding(.trailing, 20)
      .padding(.bottom, 50)
    }
  }
}
