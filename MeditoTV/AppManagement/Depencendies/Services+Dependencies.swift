//
//  Services+Dependencies.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 24/12/2022.
//

import MeditoAPI
import Factory

/// Container for services
final class ServicesContainer: SharedContainer {
    static let meditoNetworkService = Factory<NetworkingClientImplementing>(scope: .singleton) {
        MeditoAPIClient()
    }
}
