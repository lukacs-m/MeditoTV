//
//  MainNavigationFlowCoordinator.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 28/12/2022.
//

import Foundation
import SwiftUI

// enum MainFlowCoordinator: CaseIterable, Codable {
//    case home
//    case packs
//    case settings
//
//    var name: LocalizedStringKey {
//        switch self {
//        case .home:
//            return "Home"
//        case .packs:
//            return "Packs"
//        case .settings:
//            return "Settings"
//        }
//    }
//
//    var tabNumber: Int {
//        switch self {
//        case .home:
//            return 0
//        case .packs:
//            return 1
//        case .settings:
//            return 2
//        }
//    }
// }

enum PageType: String, Codable {
    case article
    case daily
    case folder
    case session
}

// Main TabView Destinations
final class MainNavigationFlowCoordinator {
    @MainActor @ViewBuilder
    func goToPage(for destination: Navigable) -> some View {
        switch destination.type {
        case PageType.folder.rawValue:
            FolderView(coordinationItem: destination)
//            FolderView(id: destination.getId()).eraseToAnyView() // folderPage(with: pack.id)
        case PageType.daily.rawValue, PageType.session.rawValue:
//            return SessionView(sessionId: destination.getId(),
//                               sessionType: destination.getType(),
//                               sessionColor: color).eraseToAnyView() // audioPage(for: pack.id, and: pack.type)
            Text("session")
        case PageType.article.rawValue:
            Text("article") // textPage(with: pack.id)
        default:
            Text("Don't know this type of context")
        }
    }
}
