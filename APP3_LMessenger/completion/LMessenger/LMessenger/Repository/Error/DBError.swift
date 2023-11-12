//
//  DBError.swift
//  LMessenger
//
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
