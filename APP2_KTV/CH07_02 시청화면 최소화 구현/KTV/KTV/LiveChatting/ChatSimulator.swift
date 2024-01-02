//
//  ChatSimulator.swift
//  KTV
//
//  Created by Lecture on 2023/09/02.
//

import Foundation

struct ChatMessage {
    
    let isMine: Bool
    let text: String
}

@MainActor class ChatSimulator {
    typealias MessageHandler = ((ChatMessage) -> Void)
    
    private var callback: MessageHandler?
    private var task: Task<Void, Never>?
    
    deinit {
        self.task?.cancel()
    }
    
    func start() {
        self.task = .init(operation: { [weak self] in
            guard let self else {
                return
            }

            while true {
                do {
                    try Task.checkCancellation()
                    
                    let randomSeconds = UInt64.random(in: 10...20)
                    try await Task.sleep(nanoseconds: 1_000_000_000 / 10 * randomSeconds)
                    let message = self.randomMessage
                    self.callback?(.init(isMine: false, text: message))
                } catch {
                    break
                }
            }
        })
    }
    
    func stop() {
        self.task?.cancel()
        self.task = nil
    }
    
    func sendMessage(_ message: String) {
        self.callback?(.init(isMine: true, text: message))
    }
    
    func setMessageHandler(_ handler: MessageHandler?) {
        self.callback = handler
    }
    
    private var randomMessage: String {
        let messages = [
            "안녕하세요!",
            "모두 안녕하세요!",
            "안녕하신가요?",
            "안녕하십니까?",
            "저는 새로운 회원입니다.",
            "반갑습니다. 제 이름은 [이름]이에요.",
            "안녕하세요! 함께 활동하려고 합니다.",
            "감사합니다!",
            "고맙습니다!",
            "정말로 감사합니다!",
            "도움이 되어서 감사합니다.",
            "어떤 의견이 있나요?",
            "여기 무슨 이야기가 진행되고 있나요?",
            "무엇을 이야기하고 싶으세요?",
            "그렇군요.",
            "정말로?",
            "흥미로운 주제네요!",
            "이야기하고 싶어요.",
            "잘 가요!",
            "다음에 또 만나요!",
            "즐거운 시간 되세요!",
            "안녕히 가세요!",
            "도와주세요!",
            "어떻게 해야 할까요?",
            "도움이 필요해요!",
            "도움이 필요한데, 누가 도와줄 수 있을까요?",
        ]
        
        return messages[Int.random(in: 0..<messages.count)]
    }
    
}
