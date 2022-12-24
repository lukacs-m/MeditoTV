//
//  Shortcuts.swift
//
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Foundation

// MARK: - Shortcuts

public struct Shortcuts: Codable, Sendable {
    public let shortcuts: [Shortcut]

    enum CodingKeys: String, CodingKey {
        case shortcuts = "data"
    }

    public init(shortcuts: [Shortcut]) {
        self.shortcuts = shortcuts
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(Shortcuts.self, from: data)
    }
}

// MARK: - Shortcut

public struct Shortcut: Codable, Identifiable, Sendable {
    public let title, type, id: String?
    public let cover: String?
    public let primaryColor: String?
    public let backgroundImage: String?

    enum CodingKeys: String, CodingKey {
        case title, type, id, cover
        case primaryColor = "color_primary"
        case backgroundImage = "background_image"
    }

    public init(title: String?, type: String?, id: String?,
                cover: String?, primaryColor: String?, backgroundImage: String? = nil) {
        self.title = title
        self.type = type
        self.id = id
        self.cover = cover
        self.primaryColor = primaryColor
        self.backgroundImage = backgroundImage
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(Shortcut.self, from: data)
    }
}
