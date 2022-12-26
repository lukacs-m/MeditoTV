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

public struct Course: Codable, Identifiable, Sendable, Diplayable {
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

public protocol Diplayable {
    var cover: String? { get }
    var primaryColor: String? { get }

    var imageURL: URL? { get }
    var backgroundColor: String { get }
}

public extension Diplayable {
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

public protocol PrimaryColorable {
    var primaryColor: String? { get }
    func getPrimaryColor() -> String
}

public extension PrimaryColorable {
    func getPrimaryColor() -> String {
        guard let primaryColor = primaryColor, !primaryColor.isEmpty else {
            return "FFFFFF"
        }

        return primaryColor
    }
}

public protocol SecondaryColorable {
    var secondaryColor: String? { get }
    func getSecondaryColor() -> String
}

public extension SecondaryColorable {
    func getSecondaryColor() -> String {
        guard let secondaryColor = secondaryColor, !secondaryColor.isEmpty else {
            return "000000"
        }
        let trimedSecondaryColor = secondaryColor.replacingOccurrences(of: "#FF", with: "", options: [.regularExpression])

        return trimedSecondaryColor
    }
}

// enum Config {
//    static let apiBaseUrl = "https://api.medito.app"
//
//    static func getDownloadAssetURL(for content: String) -> URL? {
//        let stringUrl = "\(Config.apiBaseUrl)/assets/\(content)?download"
//        return URL(string: stringUrl.replacingOccurrences(of: " ", with: "%20", options: [.regularExpression]))
//    }
// }
//
//
// extension MainImaging {
//    public func getImageUrl() -> URL? {
//        guard let cover = cover else {
//            return nil
//        }
//        return Config.getDownloadAssetURL(for: cover)
//    }
// }
