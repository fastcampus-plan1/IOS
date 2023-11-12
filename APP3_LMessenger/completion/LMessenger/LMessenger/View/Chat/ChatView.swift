//
//  ChatView.swift
//  LMessenger
//
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if viewModel.chatDataList.isEmpty {
                    Color.chatBg
                } else {
                    contentView
                }
            }
            .onChange(of: viewModel.chatDataList.last?.chats) { newValue in
                proxy.scrollTo(newValue?.last?.id, anchor: .bottom)
            }
        }
        .background(Color.chatBg)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.chatBg, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    viewModel.send(action: .pop)
                } label: {
                    Image("back", label: Text("뒤로가기"))
                }
                
                Text(viewModel.otherUser?.name ?? "대화방이름")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.bkText)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(decorative: "search_chat")
                Image(decorative: "bookmark")
                Image(decorative: "settings")
            }
        }
        .keyboardToolbar(height: 50) {
            HStack(spacing: 13) {
                Button {
                } label: {
                    Image("other_add", label: Text("더보기"))
                }
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images) {
                    Image("image_add", label: Text("사진첨부"))
                }
                
                Button {
                } label: {
                    Image("photo_camera", label: Text("카메라"))
                }
                
                TextField("", text: $viewModel.message)
                    .font(.system(size: 16))
                    .foregroundColor(.blackFix)
                    .focused($isFocused)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .background(Color.greyCool)
                    .cornerRadius(20)
                
                Button {
                    viewModel.send(action: .addChat(viewModel.message))
                    isFocused = false
                } label: {
                    Image("send", label: Text("전송"))
                }
                .disabled(viewModel.message.isEmpty)
            }
            .padding(.horizontal, 27)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
    }
    
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    if let message = chat.message {
                        ChatItemView(message: message,
                                     direcion: viewModel.getDirection(id: chat.userId),
                                     date: chat.date)
                        .id(chat.chatId)
                        .accessibilityElement(children: .combine)
                    } else if let photoURL = chat.photoURL {
                        ChatImageItemView(urlString: photoURL,
                                          direction: viewModel.getDirection(id: chat.userId),
                                          date: chat.date)
                        .id(chat.chatId)
                        .accessibilityElement(children: .combine)
                        .accessibility(addTraits: .isImage)
                    }
                    
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 76, height: 20)
                .background(Color.chatNotice)
                .cornerRadius(50)
            Text(dateStr)
                .font(.system(size: 10))
                .foregroundColor(.bgWh)
        }
        .padding(.top)
        .accessibilityLabel(Text(dateStr.toChatDate?.toChatDataAccesbiility ?? ""))
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatView(viewModel: .init(container: .stub,
                                      chatRoomId: "chatRoom1_id",
                                      myUserId: "user1_id",
                                      otherUserId: "user2_id"))
        }
    }
}
