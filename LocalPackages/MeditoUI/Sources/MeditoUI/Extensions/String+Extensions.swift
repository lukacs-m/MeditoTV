//
//  String+Extensions.swift
//
//
//  Created by Martin Lukacs on 29/12/2022.
//

import Foundation

extension String {
    var toMarkdown: AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString(self)
        }
    }
}
