//
//  GetFolderDetails.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 28/12/2022.
//

import Factory
import MeditoAPI
import SafeCache

protocol GetFolderDetailsUseCase: Actor {
    func execute(for id: Int) async throws -> Folder
}

actor GetFolderDetails: GetFolderDetailsUseCase {
    private let cache: SafeCache<Int, Folder>
    @LazyInjected(RepositoriesContainer.folderRepository) private var folderRepository: FolderServicing

    init() {
        cache = SafeCache(entryLifetime: APPConfig.Cache.entryLifetime,
                          maximumEntryCount: APPConfig.Cache.maximumEntryCount)
    }

    func execute(for id: Int) async throws -> Folder {
        if let cachedCourses = await cache[id] {
            return cachedCourses
        }
        do {
            let folderContainer = try await folderRepository.getFolderDetail(for: id)
            await cache.insert(folderContainer.folder, forKey: id)
            return folderContainer.folder
        } catch {
            throw error
        }
    }
}
