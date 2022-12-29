//
//  Coordinators+Dependencies.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Factory
import Foundation

/// Container for coordinators
final class CoordinatorContainer: SharedContainer {
    static let mainTabCoordinator = Factory(scope: .singleton) { MainTabCoordinator() }
    static let mainNavigationFlowCoordinator = Factory(scope: .singleton) { MainNavigationFlowCoordinator() }
}
