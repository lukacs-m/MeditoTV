//
//  Navigable.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 29/12/2022.
//

import Foundation

protocol Navigable {
    var id: String? { get }
    var navigableId: Int { get }
    var type: String? { get }
}

extension Navigable {
    var navigableId: Int {
        guard let id, let intId = Int(id) else {
            return 0
        }
        return intId
    }
}
