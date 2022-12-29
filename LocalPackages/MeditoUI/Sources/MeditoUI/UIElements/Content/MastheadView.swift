//
//  MastheadView.swift
//
//
//  Created by Martin Lukacs on 29/12/2022.
//

import Nuke
import NukeUI
import SwiftUI

public struct MastheadView: View {
    private let element: EnhancedDisplayable

    public init(element: EnhancedDisplayable) {
        self.element = element
    }

    public var body: some View {
        HStack {
            LazyImage(url: element.imageURL, resizingMode: .aspectFit)
                .frame(width: 300, height: 300)
                .padding(10)
                .clipShape(Circle())
                .shadow(radius: 5)
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
            VStack(alignment: .leading, spacing: 20) {
                if let title = element.title {
                    Text(title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.primary)
                }

                if let subtitle = element.subtitle {
                    Text(subtitle)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }

                if let description = element.description {
                    Text(description.toMarkdown)
                        .font(.body)
                        .foregroundStyle(.primary)
                }
            }
            .padding()
            .background(.regularMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            Spacer()
        }
        .padding(.vertical, 40)
    }
}

// struct MastheadUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        MastheadUIView()
//    }
// }
