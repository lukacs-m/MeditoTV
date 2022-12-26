//
//  ApplicationConfiguration.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//

import Foundation

enum APPConfig {
    enum Cache {
        static let entryLifetime: TimeInterval = 172_800 // 2 days
        static let maximumEntryCount: Int = 1000
    }
}
