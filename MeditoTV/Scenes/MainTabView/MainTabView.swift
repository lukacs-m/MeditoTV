//
//
//  MainTabView.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 23/12/2022.
//
//

import Factory
import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = MainTabViewModel()
    @Injected(CoordinatorContainer.mainTabCoordinator) private var coordinator

    @State private var selectedTab = 0

    var body: some View {
        mainContainer
    }
}

extension MainTabView {
    private var mainContainer: some View {
        tabView
    }
}

extension MainTabView {
    @ViewBuilder
    private var tabView: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabDestination.allCases, id: \.self) {
                createTabItem(for: $0)
            }
        }
    }
}

extension MainTabView {
    @ViewBuilder
    private func createTabItem(for type: MainTabDestination, shouldUpdateOffset: Bool = false) -> some View {
        LazyView(coordinator.goToPage(for: type))
            .tabItem {
                Text(type.name)
            }
            .tag(type.tabNumber)
            .accessibilityLabel(type.name)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

public struct LazyView<Content: View>: View {
    let build: () -> Content

    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    public var body: Content {
        build()
    }
}
