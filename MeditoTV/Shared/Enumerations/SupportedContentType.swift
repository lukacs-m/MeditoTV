//
//  SupportedContentType.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Foundation

enum SupportedContentType: String, Codable {
    case article
    case daily
    case folder
    case session

    static func isSupported(for type: String?) -> Bool {
        guard let type else {
            return false
        }
        return SupportedContentType(rawValue: type) != nil
    }
}
