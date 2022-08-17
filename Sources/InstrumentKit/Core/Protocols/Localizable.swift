// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol Localizable {
    func localized(to locale: Locale) -> Self
}

// MARK: - Defaults

public extension Localizable {
    func localized(to localeIdentifier: String) -> Self {
        self.localized(to: .init(identifier: localeIdentifier))
    }

    func localized(to supportedLanguage: SupportedLanguage) -> Self {
        self.localized(to: supportedLanguage.rawValue)
    }
}

// MARK: - Extensions

extension Array: Localizable where Element: Localizable {
    public func localized(to locale: Locale) -> Self {
        self.map { $0.localized(to: locale) }
    }
}
