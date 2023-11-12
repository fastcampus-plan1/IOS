//
//  HomeViewModel.swift
//  LMessenger
//
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum Action {
        case load
        case requestContacts
        case presentView(HomeModalDestination)
        case goToChat(User)
    }

    @Published var phase: Phase = .notRequested
    @Published var myUser: User?
    @Published var users: [User] = []
    @Published var modalDestination: HomeModalDestination?
    
    var userId: String
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            phase = .loading
            
            container.services.userService.getUser(userId: userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(id: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
        case .requestContacts:
            container.services.contactService.fetchContacts()
                .flatMap { users in
                    self.container.services.userService.addUserAfterContact(users: users)
                }
                .flatMap { _ in
                    self.container.services.userService.loadUsers(id: self.userId)
                }
                .receive(on: DispatchQueue.main)
                .sink { completion in
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
        case let .presentView(destination):
            modalDestination = destination
            
        case let .goToChat(otherUser):
            container.services.chatRoomService.createChatRoomIfNeeded(myUserId: userId, otherUserId: otherUser.id, otherUserName: otherUser.name)
                .sink { completion in
                    
                } receiveValue: { [weak self] chatRoom in
                    guard let `self` = self else { return }
                    self.container.navigationRouter.push(to: .chat(chatRoomId: chatRoom.chatRoomId,
                                                                   myUserId: self.userId,
                                                                   otherUserId: otherUser.id))
                }.store(in: &subscriptions)

        }
    }
}
