//
//  MindfullPacksRepository.swift
//
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Combine
import Foundation

enum MindfullPacksEndpoint {
    case shortcuts
}

extension MindfullPacksEndpoint: Endpoint {
    var host: String {
        APIConfiguration.host
    }

    var path: String {
        switch self {
        case .shortcuts:
            return APIConfiguration.EndPoints.packs
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

public protocol MindfullPacksServicing {
    func getMindfullPacks() -> AnyPublisher<MindfullPacks, Error>
    func getMindfullPacks() async throws -> MindfullPacks
}

public final class MindfullPacksRepository: MindfullPacksServicing, Sendable {
    private let apiClient: NetworkingClientImplementing

    public init(apiService: NetworkingClientImplementing) {
        apiClient = apiService
    }

    public func getMindfullPacks() -> AnyPublisher<MindfullPacks, Error> {
        apiClient.sendRequest(endpoint: MindfullPacksEndpoint.shortcuts)
    }

    public func getMindfullPacks() async throws -> MindfullPacks {
        try await apiClient.sendRequest(endpoint: MindfullPacksEndpoint.shortcuts)
    }
}

//
// public protocol MindfullPacksServicing {
//    func getMindfullPacks() -> AnyPublisher<, Error>
// }
//
// final public class MindfullPacksService: MindfullPacksServicing {
//    private var api: NetworkDataFetching
//    private var cache: Cache<String, [MindfullPack]> = Cache()
//
//    public init(apiService: NetworkDataFetching) {
//        self.api = apiService
//    }
//
//    public func getMindfullPacks() -> AnyPublisher<[MindfullPack], Error> {
//        let path = APIConfig.EndPoints.packs
//        if let cachedPacks = cache[path] {
//            return Just(cachedPacks).switchToAnyPublisher(with: Error.self)
//        }
//
//        return api.getData(ofKind: MindfullPacksContainer.self, from: path)
//            .map { [weak self] packsContainer in
//                let packs = packsContainer.mindfullPacks
//                self?.cache[path] = packs
//                return packs
//            }.eraseToAnyPublisher()
//    }
// }
