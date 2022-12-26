//
//  UseCases+Dependencies.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//

import Factory
import MeditoAPI

// MARK: - Content

/// Container for Content action related Use cases
final class UseCasesContentContainer: SharedContainer {
    static let getShortcuts = Factory<GetShortcutsUseCase>(scope: .shared) {
        GetShortcuts()
    }

    static let getCourses = Factory<GetCoursesUseCase>(scope: .shared) {
        GetCourses()
    }

    static let getMindfullPacks = Factory<GetMindfullPacksUseCase>(scope: .shared) {
        GetMindfullPacks()
    }
}
