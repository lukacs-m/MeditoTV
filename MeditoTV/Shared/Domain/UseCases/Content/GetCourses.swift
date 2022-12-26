//
//
//  GetCourses.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//
//

import Factory
import MeditoAPI
import SafeCache

protocol GetCoursesUseCase: Actor {
    func execute() async throws -> [Course]
}

actor GetCourses: GetCoursesUseCase {
    private let cacheKey = "courses"
    private let cache: SafeCache<String, [Course]>
    @LazyInjected(RepositoriesContainer.coursesRepository) private var coursesRepository: CoursesServicing

    init() {
        cache = SafeCache(entryLifetime: APPConfig.Cache.entryLifetime,
                          maximumEntryCount: APPConfig.Cache.maximumEntryCount)
    }

    func execute() async throws -> [Course] {
        if let cachedCourses = await cache[cacheKey] {
            return cachedCourses
        }
        do {
            let courses = try await coursesRepository.getCourses()
            let filtered = courses.courses.filter { SupportedContentType.isSupported(for: $0.type) }
            await cache.insert(filtered, forKey: cacheKey)
            return filtered
        } catch {
            throw error
        }
    }
}
