//
//  MainTabCoordinator.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 24/12/2022.
//

import SwiftUI

enum MainTabDestination: CaseIterable, Codable {
    case home
    case packs
    case settings

    var name: LocalizedStringKey {
        switch self {
        case .home:
            return "Home"
        case .packs:
            return "Packs"
        case .settings:
            return "Settings"
        }
    }

    var tabNumber: Int {
        switch self {
        case .home:
            return 0
        case .packs:
            return 1
        case .settings:
            return 2
        }
    }
}

// Main TabView Destinations
final class MainTabCoordinator {
    @MainActor @ViewBuilder
    func goToPage(for destination: MainTabDestination) -> some View {
        switch destination {
        case .home:
            HomeView()
        case .packs:
            MindfullPacksView()
        case .settings:
            Text("Settings")
        }
    }
}
