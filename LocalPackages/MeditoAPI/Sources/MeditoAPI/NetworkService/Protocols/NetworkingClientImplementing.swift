//
//  NetworkingClientImplementing.swift
//  
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Combine
import Foundation

public protocol NetworkingClientImplementing: AnyObject {
    var session: URLSession { get }
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) async throws -> ReturnedType
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) -> AnyPublisher<ReturnedType, Error>
}

public extension NetworkingClientImplementing {
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) async throws -> ReturnedType {
        guard let request = endpoint.request else {
            throw RequestError.invalidURL
        }
        do {
            let (data, response) = try await session.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(ReturnedType.self, from: data) else {
                    throw RequestError.decode
                }
                return decodedResponse
            default:
                throw HTTPErrors.error(for: response.statusCode)
            }
        } catch {
            throw RequestError.unknown
        }
    }

    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) -> AnyPublisher<ReturnedType, Error> {
        Deferred {
            Future { promise in
                Task { [weak self] in
                    guard let self else {
                        promise(.failure(RequestError.unknown))
                        return
                    }
                    do {
                        let result: ReturnedType = try await self.sendRequest(endpoint: endpoint)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
