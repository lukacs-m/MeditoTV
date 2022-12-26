//
//  GetMindfullPacks.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Factory
import MeditoAPI
import SafeCache

protocol GetMindfullPacksUseCase: Actor {
    func execute() async throws -> [MindfullPack]
}

actor GetMindfullPacks: GetMindfullPacksUseCase {
    private let cacheKey = "courses"
    private let cache: SafeCache<String, [MindfullPack]>
    @LazyInjected(RepositoriesContainer.mindfullPacksRepository) private var mindfullPacksRepository: MindfullPacksServicing

    init() {
        cache = SafeCache(entryLifetime: APPConfig.Cache.entryLifetime,
                          maximumEntryCount: APPConfig.Cache.maximumEntryCount)
    }

    func execute() async throws -> [MindfullPack] {
        if let cachedPacks = await cache[cacheKey] {
            return cachedPacks
        }
        do {
            let mindfullPacks = try await mindfullPacksRepository.getMindfullPacks()
            let filtered = mindfullPacks.mindfullPacks.filter { SupportedContentType.isSupported(for: $0.type) }
            await cache.insert(filtered, forKey: cacheKey)
            return filtered
        } catch {
            throw error
        }
    }
}
