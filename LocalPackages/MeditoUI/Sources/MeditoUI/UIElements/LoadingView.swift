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
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .accessibility(hidden: true)
                Spacer()
                if let title {
                    Text(title)
                }
            }.frame(minWidth: 1980, maxWidth: .infinity)
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
