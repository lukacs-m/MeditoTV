//
//  Repositories+Dependencies.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Factory
import MeditoAPI

/// Container for coordinators
final class RepositoriesContainer: SharedContainer {
    static let shortcutsRepository = Factory<ShortcutsServicing>(scope: .singleton) {
        ShortcutsRepository(apiService: ServicesContainer.meditoNetworkService())
    }

    static let coursesRepository = Factory<CoursesServicing>(scope: .singleton) {
        CoursesRepository(apiService: ServicesContainer.meditoNetworkService())
    }

    static let mindfullPacksRepository = Factory<MindfullPacksServicing>(scope: .singleton) {
        MindfullPacksRepository(apiService: ServicesContainer.meditoNetworkService())
    }

    static let folderRepository = Factory<FolderServicing>(scope: .singleton) {
        FolderRepository(apiService: ServicesContainer.meditoNetworkService())
    }
}
