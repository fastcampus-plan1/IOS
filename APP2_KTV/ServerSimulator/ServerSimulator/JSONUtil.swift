//
//  JSONUtil.swift
//  ServerSimulator
//

import Foundation

func jsonObject<T: Encodable>(for data: T) -> Any? {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(data)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("======   JSON data for \(T.self)   =====")
            print("============ \(jsonString)")
            print("========================================")
        }
        
        return try JSONSerialization.jsonObject(with: jsonData)
    } catch {
        return nil
    }
}
