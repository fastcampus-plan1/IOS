//
//  ChatRoomServiceTests.swift
//  LMessengerTests
//
//

import XCTest
import Combine
@testable import LMessenger

final class ChatRoomServiceTests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
    }

    func test_createChatRoomIfNeeded_not_existed() {
        let mockDBRepository = MockChatRoomDBRepository(mockData: nil)
        let chatRoomService = ChatRoomService(dbRepository: mockDBRepository)
        var result: ChatRoom?
        
        chatRoomService.createChatRoomIfNeeded(myUserId: "user1_id", otherUserId: "user2_id", otherUserName: "user2")
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Unexpected fail: \(error)")
                }
            } receiveValue: { chatRoom in
                result = chatRoom
            }.store(in: &subscriptions)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.otherUseId, "user2_id")
        XCTAssertEqual(result?.otherUserName, "user2")
        
        XCTAssertEqual(mockDBRepository.getChatRoomCallCount, 1)
        XCTAssertEqual(mockDBRepository.addChatRoomCallCount, 1)
    }
    
    func test_createChatRoomIfNeeded_existed() {
        let mockDBRepository = MockChatRoomDBRepository(mockData: ChatRoomObject.stub1)
        let chatRoomService = ChatRoomService(dbRepository: mockDBRepository)
        var result: ChatRoom?
        
        chatRoomService.createChatRoomIfNeeded(myUserId: "user1_id", otherUserId: "user2_id", otherUserName: "user2")
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Unexpected fail: \(error)")
                }
            } receiveValue: { chatRoom in
                result = chatRoom
            }.store(in: &subscriptions)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.otherUseId, "user2_id")
        XCTAssertEqual(result?.otherUserName, "user2")
        
        XCTAssertEqual(mockDBRepository.getChatRoomCallCount, 1)
        XCTAssertEqual(mockDBRepository.addChatRoomCallCount, 0)
    }
}

class MockChatRoomDBRepository: ChatRoomDBRepositoryType {
    
    let mockData: Any?
    
    var addChatRoomCallCount = 0
    var getChatRoomCallCount = 0
    
    init(mockData: Any?) {
        self.mockData = mockData
    }
    
    func getChatRoom(myUserId: String, otherUserId: String) -> AnyPublisher<LMessenger.ChatRoomObject?, LMessenger.DBError> {
        getChatRoomCallCount += 1
        return Just(mockData as? ChatRoomObject).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }
    
    func addChatRoom(_ object: LMessenger.ChatRoomObject, myUserId: String) -> AnyPublisher<Void, LMessenger.DBError> {
        addChatRoomCallCount += 1
        return Just(()).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }
    
    func loadChatRooms(myUserId: String) -> AnyPublisher<[LMessenger.ChatRoomObject], LMessenger.DBError> {
        Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }
    
    func updateChatRoomLastMessage(chatRoomId: String, myUserId: String, myUserName: String, otherUserId: String, lastMessage: String) -> AnyPublisher<Void, LMessenger.DBError> {
        Just(()).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }
}
