//
//  MeditoAPI+Extensions.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 26/12/2022.
//

import MeditoAPI
import MeditoUI

// MARK: - Displaying protocols conformance

extension Course: Displayable {}
extension Shortcut: Displayable {}
extension MindfullPack: Displayable {}
extension Folder: EnhancedDisplayable {}
extension ItemFolderContent: PageContentTypable {}

// MARK: - Navigation flow protocol conformance

extension Course: Navigable {}
extension Shortcut: Navigable {}
extension MindfullPack: Navigable {}
