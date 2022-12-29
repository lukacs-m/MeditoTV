//
//
//  FolderViewModel.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 28/12/2022.
//
//

import Factory
import Foundation
import MeditoAPI

struct FolderModel {
    let folder: Folder
}

@MainActor
final class FolderViewModel: ObservableObject, Sendable {
    @Published private(set) var pageState: PageState<FolderModel> = .loading

    @LazyInjected(UseCasesContentContainer.getFolderDetails) private var getFolderDetails: GetFolderDetailsUseCase

    init() {
        setUp()
    }

    func resetPageState() {
        pageState = .loading
    }

    func fetchContent(for coordinationItem: Navigable) async {
        if Task.isCancelled { return }
        do {
            let folder = try await getFolderDetails.execute(for: coordinationItem.navigableId)
            try Task.checkCancellation()
            updatePageStage(with: .loaded(FolderModel(folder: folder)))
        } catch {
            updatePageStage(with: .error(error.localizedDescription))
        }
    }
}

private extension FolderViewModel {
    func setUp() {}

    func updatePageStage(with state: PageState<FolderModel>) {
        pageState = state
    }
}
