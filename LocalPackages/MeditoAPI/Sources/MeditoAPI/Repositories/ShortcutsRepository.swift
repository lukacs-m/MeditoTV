//
//  ShortcutsRepository.swift
//
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Combine
import Foundation

enum ShortcutsEndpoint {
    case shortcuts
}

extension ShortcutsEndpoint: Endpoint {
    var host: String {
        APIConfiguration.host
    }

    var path: String {
        switch self {
        case .shortcuts:
            return APIConfiguration.EndPoints.shortcuts
        }
    }

    var method: CRUDRequestMethod {
        switch self {
        case .shortcuts:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = APIConfiguration.apiKey
        switch self {
        case .shortcuts:
            return [
                "Authorization": "\(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }

    var body: [String: String]? {
        nil
    }
}

public protocol ShortcutsServicing {
    func getShortcuts() -> AnyPublisher<Shortcuts, Error>
    func getShortcuts() async throws -> Shortcuts
}

public final class ShortcutsRepository: ShortcutsServicing, Sendable {
    private let apiClient: NetworkingClientImplementing

    public init(apiService: NetworkingClientImplementing) {
        apiClient = apiService
    }

    public func getShortcuts() -> AnyPublisher<Shortcuts, Error> {
        apiClient.sendRequest(endpoint: ShortcutsEndpoint.shortcuts)
    }

    public func getShortcuts() async throws -> Shortcuts {
        try await apiClient.sendRequest(endpoint: ShortcutsEndpoint.shortcuts)
    }
}
