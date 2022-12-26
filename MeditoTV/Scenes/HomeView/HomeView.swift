//
//
//  HomeView.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//
//

import MeditoAPI
import MeditoUI
import NukeUI
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        mainContainer
            .overlay(overlayView)
    }

    @ViewBuilder
    private var overlayView: some View {
        switch viewModel.pageState {
        case .loading:
            LoadingView(title: "Loading")
                .task {
                    await viewModel.fetchHomeContent()
                }
        default:
            EmptyView()
        }
    }
}

extension HomeView {
    @ViewBuilder
    var mainContainer: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 40) {
                if let sections = viewModel.pageState.value {
                    ForEach(sections.sections) { section in
                        sectionView(for: section)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func sectionView(for section: PageSection<any Sendable>) -> some View {
        VStack(alignment: .leading) {
            Text(section.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.horizontal, 64)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 32) {
                    if let shortcuts = section.content as? [Shortcut] {
                        shortcutSectionCarrousel(for: shortcuts)
                    }
                    if let courses = section.content as? [Course] {
                        coursesSectionCarrousel(for: courses)
                    }
                }
                .padding([.bottom, .horizontal], 64)
                .padding(.top, 25)
            }
        }
        .focusSection()
    }

    @ViewBuilder
    func shortcutSectionCarrousel(for shortcuts: [Shortcut]) -> some View {
        ForEach(shortcuts) { shortcut in
            NavigationLink {
                EmptyView()
            } label: {
                DisplayableItemView(element: shortcut)
                    .frame(width: 380, height: 250)
            }
            .buttonStyle(.card)
        }
    }

    @ViewBuilder
    func coursesSectionCarrousel(for courses: [Course]) -> some View {
        ForEach(courses) { course in
            NavigationLink {
                EmptyView()
            } label: {
                DisplayableItemView(element: course)
                    .frame(width: 420, height: 320)
            }
            .buttonStyle(.card)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
