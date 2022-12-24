//
//  Repositories+Dependencis.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 24/12/2022.
//

import MeditoAPI
import Factory

/// Container for coordinators
final class RepositoriesContainer: SharedContainer {
    static let shortcutsRepository = Factory<ShortcutsServicing>(scope: .singleton) {
        ShortcutsRepository(apiService: ServicesContainer.meditoNetworkService())
    }
    
    static let coursesRepository = Factory<CoursesServicing>(scope: .singleton) {
        CoursesRepository(apiService: ServicesContainer.meditoNetworkService())
    }
}
