//
//  Courses.swift
//
//
//  Created by Martin Lukacs on 24/12/2022.
//

import Foundation

// MARK: - Courses

public struct Courses: Codable, Sendable {
    public let courses: [Course]

    enum CodingKeys: String, CodingKey {
        case courses = "data"
    }

    public init(courses: [Course]) {
        self.courses = courses
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(Courses.self, from: data)
    }
}

// MARK: - Course

public struct Course: Codable, Identifiable, Sendable {
    public let title, subtitle, type, id: String?
    public let cover: String?
    public let backgroundImage: String?
    public let primaryColor: String?

    enum CodingKeys: String, CodingKey {
        case title, subtitle, type, id, cover
        case backgroundImage = "background_image"
        case primaryColor = "color_primary"
    }

    public init(title: String?, subtitle: String?, type: String?,
                id: String?, cover: String?, backgroundImage: String?, primaryColor: String?) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.id = id
        self.cover = cover
        self.backgroundImage = backgroundImage
        self.primaryColor = primaryColor
    }

    public init(data: Data) throws {
        self = try JSONDecoder().decode(Course.self, from: data)
    }
}
