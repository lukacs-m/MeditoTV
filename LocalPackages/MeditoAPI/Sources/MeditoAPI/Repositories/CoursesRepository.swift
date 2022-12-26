//
//  CoursesRepository.swift
//
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Combine
import Foundation

enum CoursesEndpoint {
    case courses
}

extension CoursesEndpoint: Endpoint {
    var host: String {
        APIConfiguration.host
    }

    var path: String {
        switch self {
        case .courses:
            return APIConfiguration.EndPoints.courses
        }
    }

    var method: CRUDRequestMethod {
        switch self {
        case .courses:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = APIConfiguration.apiKey
        switch self {
        case .courses:
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

public protocol CoursesServicing {
    func getCourses() -> AnyPublisher<Courses, Error>
    func getCourses() async throws -> Courses
}

public final class CoursesRepository: CoursesServicing, Sendable {
    private let apiClient: NetworkingClientImplementing

    public init(apiService: NetworkingClientImplementing) {
        apiClient = apiService
    }

    public func getCourses() -> AnyPublisher<Courses, Error> {
        apiClient.sendRequest(endpoint: CoursesEndpoint.courses)
    }

    public func getCourses() async throws -> Courses {
        try await apiClient.sendRequest(endpoint: CoursesEndpoint.courses)
    }
}
