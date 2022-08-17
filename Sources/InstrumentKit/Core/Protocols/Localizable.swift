// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol Localizable {
    func localized(to locale: Locale) throws -> Self
}

// MARK: - Defaults

public extension Localizable {
    func localized(to languageCode: String) throws -> Self {
        try self.localized(to: .init(identifier: languageCode))
    }
}

// MARK: - Extensions

public extension Array where Element: Localizable {
    func localized(to locale: Locale) throws -> Self {
        try self.map { try $0.localized(to: locale) }
    }

    func localized(to languageCode: String) throws -> Self {
        try self.localized(to: .init(identifier: languageCode))
    }
}
