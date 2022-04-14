//
//  APIError.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Foundation

enum APIError: Error {
    case timeout
    case notSupported
    case handshakeFailure
    case unauthorized
    case unableToDownload
}
