//
//  Errors.swift
//  Movies
//
//  Created by Dewith on 2026-07-19.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not found"
        case let .dataLoadingFailed(underlyingError):
            return "Failed to load API configuration data: \(underlyingError.localizedDescription)"
        case let .decodingFailed(underlyingError):
            return "Failed to decode API configuration: \(underlyingError.localizedDescription)"
        }
    }
}


enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed

    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let err):
            return "Failed to parse URL response: \(err.localizedDescription)"
        case .missingConfig:
            return "Missing API configuration."
        case .urlBuildFailed:
            return "Failed to build URL."

        }
    }
}
