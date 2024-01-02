//
//  DataLoader.swift
//  KTV
//
//  Created by Lecture on 2023/09/10.
//

import Foundation

struct DataLoader {
    private static let session: URLSession = .shared
    
    static func load<T: Decodable>(url: String, for type: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw URLError(.unsupportedURL)
        }
        
        let data = try await Self.session.data(for: .init(url: url)).0
        let jsonDecoder = JSONDecoder()

        return try jsonDecoder.decode(T.self, from: data)
    }
    
}
