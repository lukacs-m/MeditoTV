//
//  Services+Dependencies.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Factory
import MeditoAPI

/// Container for services
final class ServicesContainer: SharedContainer {
    static let meditoNetworkService = Factory<NetworkingClientImplementing>(scope: .singleton) {
        MeditoAPIClient()
    }
}
