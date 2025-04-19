//
//  Optionals+Ext.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import SwiftUI

extension Optional where Wrapped == String {
    var value: String {
        switch self {
        case .some(let value): return value
        case .none: return ""
        }
    }
}
