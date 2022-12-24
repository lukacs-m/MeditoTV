//
//  MeditoAPIClient.swift
//
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Foundation

public final class MeditoAPIClient: Sendable, NetworkingClientImplementing {
    public let session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
