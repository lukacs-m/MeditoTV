//
//  FolderItemTile.swift
//
//
//  Created by Martin Lukacs on 29/12/2022.
//

import SwiftUI

public struct FolderItemTile: View {
    private let item: PageContentTypable
    private let color: String

    public init(item: PageContentTypable, color: String) {
        self.item = item
        self.color = color
    }

    private var contrastedColor: Color {
        Color.black.contrastRatio(with: Color(hex: color)) < 4.5 ? .white.opacity(0.7) : Color(hex: color)
    }

    public var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 15) {
                Image(systemName: PageContentType.getPageContentTypeIcon(for: item.type))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width / 5)
                    .padding(10)
                    .padding(.leading, 15)
                    .foregroundColor(contrastedColor)

                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    if let title = item.title {
                        Text(title)
                            .lineLimit(3)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    if let subtitle = item.subtitle {
                        Text(subtitle)
                            .lineLimit(1)
                            .fontWeight(.light)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    Spacer()
                }
                .padding(0)
                .layoutPriority(1)
                Spacer()
            }
            .background(.regularMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .inset(by: 2)
                .stroke(contrastedColor, lineWidth: 2))
        }
    }
}

// struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
// }

enum PageContentType: String, Codable {
    case article
    case daily
    case folder
    case session

    static func getPageContentTypeIcon(for type: String?) -> String {
        guard let type else {
            return ""
        }
        switch type {
        case article.rawValue:
            return "text.book.closed.fill"
        case folder.rawValue:
            return "books.vertical.fill"
        default:
            return "play.circle.fill"
        }
    }
}

public protocol PageContentTypable {
    var title: String? { get }
    var subtitle: String? { get }

    var type: String? { get }
}
