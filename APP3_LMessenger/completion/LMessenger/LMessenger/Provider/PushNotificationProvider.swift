//
//  PushNotificationProvider.swift
//  LMessenger
//
//

import Foundation
import Combine

protocol PushNotificationProviderType {
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never>
}

class PushNotificationProvider: PushNotificationProviderType {
    
    private let serverURL: URL = URL(string: "https://fcm.googleapis.com/fcm/send")!
    private let serverKey = "AAAAW5t2fEk:APA91bEOlMgt6d_8kDm-L9kSFoQKq6ZpJYxjBxDTY5JCvAwB-dZdsGOG_9SJfvz_-5Yq_3cBhAepX38glI70N7YjuS6pbT13PNbMjafUkBzHoODlXLSLXraqRQhlxJwbuAGChk9YMLio"
    
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never> {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(object)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
