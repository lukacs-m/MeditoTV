//
//  FolderRepository.swift
//
//
//  Created by Martin Lukacs on 28/12/2022.
//

import Combine
import Foundation

enum FolderEndpoint {
    case folderDetail(id: Int)
}

extension FolderEndpoint: Endpoint {
    var host: String {
        APIConfiguration.host
    }

    var path: String {
        switch self {
        case let .folderDetail(id):
            return "\(APIConfiguration.EndPoints.folder)/\(id)"
        }
    }

    var method: CRUDRequestMethod {
        switch self {
        case .folderDetail:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = APIConfiguration.apiKey
        switch self {
        case .folderDetail:
            return [
                "Authorization": "\(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .folderDetail:
            return APIConfiguration.DefaultParams.folderParams
        }
    }
}

public protocol FolderServicing {
    func getFolderDetail(for id: Int) -> AnyPublisher<FolderContainer, Error>
    func getFolderDetail(for id: Int) async throws -> FolderContainer
}

public final class FolderRepository: FolderServicing, Sendable {
    private let apiClient: NetworkingClientImplementing

    public init(apiService: NetworkingClientImplementing) {
        apiClient = apiService
    }

    public func getFolderDetail(for id: Int) -> AnyPublisher<FolderContainer, Error> {
        apiClient.sendRequest(endpoint: FolderEndpoint.folderDetail(id: id))
    }

    public func getFolderDetail(for id: Int) async throws -> FolderContainer {
        try await apiClient.sendRequest(endpoint: FolderEndpoint.folderDetail(id: id))
    }
}
