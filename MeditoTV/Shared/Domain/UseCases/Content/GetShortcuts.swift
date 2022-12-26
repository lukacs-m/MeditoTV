//
//
//  GetShortcuts.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//
//

import Factory
import MeditoAPI
import SafeCache

protocol GetShortcutsUseCase: Actor {
    func execute() async throws -> [Shortcut]
}

actor GetShortcuts: GetShortcutsUseCase {
    private let cacheKey = "shortcuts"
    private let cache: SafeCache<String, [Shortcut]>
    @LazyInjected(RepositoriesContainer.shortcutsRepository) private var shortcutsRepository: ShortcutsServicing

    init() {
        cache = SafeCache(entryLifetime: APPConfig.Cache.entryLifetime,
                          maximumEntryCount: APPConfig.Cache.maximumEntryCount)
    }

    func execute() async throws -> [Shortcut] {
        if let cachedShortcuts = await cache[cacheKey] {
            return cachedShortcuts
        }
        do {
            let shortcuts = try await shortcutsRepository.getShortcuts()
            let filtered = shortcuts.shortcuts.filter { SupportedContentType.isSupported(for: $0.type) }
            await cache.insert(filtered, forKey: cacheKey)
            return filtered
        } catch {
            throw error
        }
    }
}
