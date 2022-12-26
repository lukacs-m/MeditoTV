//
//  PageState.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 26/12/2022.
//

import Foundation

enum PageState<PageContent> {
    case loading
    case loaded(PageContent)
    case empty
    case error(String)

    var value: PageContent? {
        if case let .loaded(value) = self {
            return value
        }
        return nil
    }
}
