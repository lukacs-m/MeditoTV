//
//  MindfullPacks.swift
//
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Foundation

// MARK: - Packs

public struct MindfullPacks: Codable, Sendable {
    public let mindfullPacks: [MindfullPack]

    enum CodingKeys: String, CodingKey {
        case mindfullPacks = "data"
    }

    public init(packs: [MindfullPack]) {
        mindfullPacks = packs
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(MindfullPacks.self, from: data)
    }
}

// MARK: - Pack

public struct MindfullPack: Codable, Identifiable, Sendable {
    public let title, subtitle, type, id: String?
    public let primaryColor: String?
    public let secondaryColor: String?
    public var cover: String?
    public var backgroundImage: String?

    enum CodingKeys: String, CodingKey {
        case title, subtitle, type, id
        case primaryColor = "color_primary"
        case secondaryColor = "color_secondary"
        case cover
        case backgroundImage = "background_image"
    }

    public init(title: String?, subtitle: String?, type: String?,
                id: String?, primaryColor: String?, secondaryColor: String?,
                cover: String? = nil, backgroundImage: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.id = id
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.cover = cover
        self.backgroundImage = backgroundImage
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(MindfullPack.self, from: data)
    }
}
