//
//  ContactService.swift
//  LMessenger
//
//

import Foundation
import Combine
import Contacts

enum ContactError: Error {
    case permissionDenied
}

protocol ContactServiceType {
    func fetchContacts() -> AnyPublisher<[User], ServiceError>
}

class ContactService: ContactServiceType {
    
    func fetchContacts() -> AnyPublisher<[User], ServiceError> {
        Future { [weak self] promise in
            self?.fetchContacts {
                promise($0)
            }
        }
        .mapError { .error($0) }
        .eraseToAnyPublisher()
    }
    
    private func fetchContacts(completion: @escaping (Result<[User], Error>) -> Void) {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { granted, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard granted else {
                completion(.failure(ContactError.permissionDenied))
                return
            }
            
            DispatchQueue.global().async { [weak self] in
                self?.fetchContacts(store: store, completion: completion)
            }
        }
    }
    
    private func fetchContacts(store: CNContactStore, completion: @escaping (Result<[User], Error>) -> Void) {
        let keyToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        
        let request = CNContactFetchRequest(keysToFetch: keyToFetch)
        
        var users: [User] = []
        
        do {
            try store.enumerateContacts(with: request) { contact, _ in
                let name = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
                let phoneNumber = contact.phoneNumbers.first?.value.stringValue
                let user: User = .init(id: UUID().uuidString, name: name, phoneNumber: phoneNumber)
                
                users.append(user)
            }
            completion(.success(users))
        } catch {
            completion(.failure(error))
        }
    }
}

class StubContactService: ContactServiceType {
    
    func fetchContacts() -> AnyPublisher<[User], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
