//
//
//  MindfullPacksView.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 26/12/2022.
//
//

import MeditoUI
import SwiftUI

struct MindfullPacksView: View {
    @StateObject private var viewModel = MindfullPacksViewModel()

    private let columns = [
        GridItem(.adaptive(minimum: 420))
    ]
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
                    await viewModel.fetchContent()
                }
        default:
            EmptyView()
        }
    }
}

extension MindfullPacksView {
    @ViewBuilder
    var mainContainer: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 40) {
                if let content = viewModel.pageState.value {
                    ForEach(content.packs) { packs in
                        NavigationLink {
                            EmptyView()
                        } label: {
                            DisplayableItemView(element: packs)
                                .frame(width: 420, height: 380)
                        }
                        .buttonStyle(.card)
                    }
                }
            }.focusSection()
                .padding([.bottom, .horizontal], 64)
        }
    }
}

struct MindfullPacksView_Previews: PreviewProvider {
    static var previews: some View {
        MindfullPacksView()
    }
}
