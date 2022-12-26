//
//
//  MindfullPacksViewModel.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 26/12/2022.
//
//

import Factory
import Foundation
import MeditoAPI

struct MindfullPacksModel {
    let packs: [MindfullPack]
}

@MainActor
final class MindfullPacksViewModel: ObservableObject, Sendable {
    @Published private(set) var pageState: PageState<MindfullPacksModel> = .loading
    @LazyInjected(UseCasesContentContainer.getMindfullPacks) private var getMindfullPacks: GetMindfullPacksUseCase

    init() {
        setUp()
    }

    func fetchContent() async {
        if Task.isCancelled { return }
        do {
            let packs = try await getMindfullPacks.execute()
            try Task.checkCancellation()
            updatePageStage(with: .loaded(MindfullPacksModel(packs: packs)))
        } catch {
            updatePageStage(with: .error(error.localizedDescription))
        }
    }
}

private extension MindfullPacksViewModel {
    func setUp() {}

    func updatePageStage(with state: PageState<MindfullPacksModel>) {
        pageState = state
    }
}
