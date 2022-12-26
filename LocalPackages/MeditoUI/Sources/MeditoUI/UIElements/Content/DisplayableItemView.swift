//
//  DisplayableItemView.swift
//
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Nuke
import NukeUI
import SwiftUI

public struct DisplayableItemView: View {
    let element: Displayable

    public init(element: Displayable) {
        self.element = element
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                LazyImage(url: element.imageURL, resizingMode: .aspectFit)
                    .padding(.vertical, 20)
                    .frame(height: proxy.size.height * 0.65)
                    .background(Color(hex: element.backgroundColor))

                VStack(alignment: .leading) {
                    Spacer()
                    Text(element.title ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .lineLimit(3)
                        .fixedSize()
                    if let subtitle = element.subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    Spacer()
                }
                .padding([.horizontal, .bottom])
            }.background(.ultraThickMaterial)
        }
    }
}

//
// struct DisplayableItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayableItemView(element:)
//            .frame(width: 400, height: 400)
//            .environmentObject(ArticleBookmarkViewModel.shared)
//    }
// }
