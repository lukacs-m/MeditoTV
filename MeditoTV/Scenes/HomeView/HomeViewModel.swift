//
//
//  HomeViewModel.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//
//

import Factory
import Foundation

struct PageSection<ContentType: Sendable>: Identifiable, Sendable {
    let id: String
    let order: Int
    let title: String
    let content: ContentType
}

struct HomePageModel {
    let sections: [PageSection<any Sendable>]
}

private enum HomePageSections {
    case shortcuts
    case courses

    var id: String {
        switch self {
        case .shortcuts:
            return "Shortcuts"
        case .courses:
            return "Courses"
        }
    }

    var order: Int {
        switch self {
        case .shortcuts:
            return 0
        case .courses:
            return 1
        }
    }
}

@MainActor
final class HomeViewModel: ObservableObject, Sendable {
    @Published private(set) var pageState: PageState<HomePageModel> = .loading
    @LazyInjected(UseCasesContentContainer.getCourses) private var getCourses: GetCoursesUseCase
    @LazyInjected(UseCasesContentContainer.getShortcuts) private var getShortcuts: GetShortcutsUseCase

    init() {
        setUp()
    }

    func fetchHomeContent() async {
        if Task.isCancelled { return }
        do {
            async let shortcuts = fetchSection(for: .shortcuts)
            async let courses = fetchSection(for: .courses)

            // This is a network parallele call for tall the above endpoints
            let sections = try await [
                shortcuts,
                courses
            ]
            try Task.checkCancellation()
            let sortedSections = sections.sorted { $0.order < $1.order }
            updatePageStage(with: .loaded(HomePageModel(sections: sortedSections)))
        } catch {
            updatePageStage(with: .error(error.localizedDescription))
        }
    }
}

private extension HomeViewModel {
    func setUp() {}

    func updatePageStage(with state: PageState<HomePageModel>) {
        pageState = state
    }

    func fetchSection(for type: HomePageSections) async throws -> PageSection<any Sendable> {
        let contentSection = try await sectionContent(for: type)
        return PageSection(id: type.id,
                           order: type.order,
                           title: type.id,
                           content: contentSection)
    }

    func sectionContent(for type: HomePageSections) async throws -> any Sendable {
        switch type {
        case .shortcuts:
            return try await getShortcuts.execute()
        case .courses:
            return try await getCourses.execute()
        }
    }
}
