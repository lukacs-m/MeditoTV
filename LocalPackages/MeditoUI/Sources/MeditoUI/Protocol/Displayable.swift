//
//  Displayable.swift
//
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Foundation

public protocol Displayable {
    var title: String? { get }
    var subtitle: String? { get }
    var cover: String? { get }
    var primaryColor: String? { get }

    var imageURL: URL? { get }
    var backgroundColor: String { get }
}

public extension Displayable {
    var imageURL: URL? {
        guard let cover = cover else {
            return nil
        }

        let stringUrl = "https://api.medito.app/assets/\(cover)?download"
        return URL(string: stringUrl.replacingOccurrences(of: " ", with: "%20", options: [.regularExpression]))
    }

    var backgroundColor: String {
        guard let primaryColor = primaryColor, !primaryColor.isEmpty else {
            return "FFFFFF"
        }

        return primaryColor
    }
}
