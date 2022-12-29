//
//  Folder.swift
//
//
//  Created by Martin Lukacs on 28/12/2022.
//

import Foundation

// MARK: - FolderContainer

public struct FolderContainer: Codable, Sendable {
    public let folder: Folder

    enum CodingKeys: String, CodingKey {
        case folder = "data"
    }

    public init(content: Folder) {
        folder = content
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(FolderContainer.self, from: data)
    }
}

// MARK: - Folder

public struct Folder: Codable, Identifiable, Sendable {
    public let internalId: Int
    public let title, description, subtitle: String?
    public let cover, primaryColor: String?
    public let backgroundImage: String?
    public let folderItems: [FolderItem]

    enum CodingKeys: String, CodingKey {
        case internalId = "id"
        case title, cover, subtitle
        case backgroundImage = "background_image"
        case primaryColor = "color_primary"
        case description
        case folderItems = "items"
    }

    public init(id: Int,
                title: String?,
                description: String?,
                cover: String?,
                subtitle: String?,
                primaryColor: String?,
                backgroundImage: String?,
                folderItems: [FolderItem]) {
        internalId = id
        self.title = title
        self.description = description
        self.subtitle = subtitle
        self.cover = cover
        self.primaryColor = primaryColor
        self.backgroundImage = backgroundImage
        self.folderItems = folderItems
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(Folder.self, from: data)
    }

    public var id: String {
        String(internalId)
    }

    public var itemsContent: [ItemFolderContent] {
        folderItems.map(\.content)
    }
}

// MARK: - FolderItem

public struct FolderItem: Codable, Identifiable, Sendable {
    public var id = UUID().uuidString
    public let content: ItemFolderContent

    enum CodingKeys: String, CodingKey {
        case content = "item"
    }

    public init(content: ItemFolderContent) {
        self.content = content
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(FolderItem.self, from: data)
    }
}

// MARK: - Item

public struct ItemFolderContent: Codable, Identifiable, Sendable {
    public let id: Int
    public let type: String?
    public let title, subtitle: String?

    public init(id: Int,
                type: String?,
                title: String?,
                subtitle: String?) {
        self.id = id
        self.type = type
        self.title = title
        self.subtitle = subtitle
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(ItemFolderContent.self, from: data)
    }
}
