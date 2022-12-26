//
//  LoadingView.swift
//
//
//  Created by Martin Lukacs on 26/12/2022.
//

import SwiftUI

public struct LoadingView: View {
    let title: LocalizedStringKey?

    /**
     Returns a Loading Screen.

     - Parameters:
     - text: The Text to display.
     */
    public init(title: LocalizedStringKey?) {
        self.title = title
    }

    public var body: some View {
        ZStack {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .accessibility(hidden: true)
                    .padding(.bottom, 20)
                if let title {
                    Text(title)
                        .fixedSize()
                }
            }
            .padding(40)
            .background(.ultraThickMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading View")
        .accessibility(identifier: "loadingview")
    }
}

struct LoadingView_Previews: PreviewProvider {
    static let text: LocalizedStringKey = "Loading"

    static var previews: some View {
        Group {
            LoadingView(title: text)
                .previewDisplayName("Light")
            LoadingView(title: text)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
