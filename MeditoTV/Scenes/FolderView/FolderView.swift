//
//
//  FolderView.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 28/12/2022.
//
//

import Factory
import MeditoUI
import SwiftUI

struct FolderView: View {
    @StateObject private var viewModel = FolderViewModel()
    var coordinationItem: Navigable

    private let columns = [
        GridItem(.adaptive(minimum: 400))
    ]

    var body: some View {
        mainContainer
            .overlay(overlayView)
            .onAppear {
                if viewModel.pageState.value == nil {
                    viewModel.resetPageState()
                }
            }
    }

    @ViewBuilder
    private var overlayView: some View {
        switch viewModel.pageState {
        case .loading:
            LoadingView(title: "Loading")
                .task {
                    await viewModel.fetchContent(for: coordinationItem)
                }
        default:
            EmptyView()
        }
    }
}

extension FolderView {
    @ViewBuilder
    var mainContainer: some View {
        if let content = viewModel.pageState.value {
            VStack(spacing: 0) {
                MastheadView(element: content.folder)
                    .padding([.horizontal], 64)
                Divider().frame(width: 500)
                    .frame(height: 2)
                    .overlay(.black)
                    .padding(.bottom, 10)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(content.folder.itemsContent) { item in
                            NavigationLink {
                                EmptyView()
                            } label: {
                                FolderItemTile(item: item, color: content.folder.backgroundColor)
                                    .frame(height: 200)
                            }
                            .buttonStyle(.card)
                        }
                    }
                    .padding([.vertical, .horizontal], 64)
                    .focusSection()
                }.focusSection()
                    .mask(VStack(spacing: 0) {
                        LinearGradient(gradient: Gradient(colors:
                            [Color.clear, Color.black]),
                        startPoint: .top, endPoint: .bottom)
                            .frame(height: 65)

                        // Middle
                        Rectangle().fill(Color.black)

                        // bottom gradient
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black]),
                                       startPoint: .top, endPoint: .bottom)
                            .frame(height: 100)
                    })
            }.background(LinearGradient(gradient: Gradient(colors: [Color(hex: content.folder.backgroundColor), .black]),
                                        startPoint: .top,
                                        endPoint: .bottom))
        } else {
            ProgressView()
        }
    }
}

// struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView(coordinationItem: <#Navigable#>)
//    }
// }
