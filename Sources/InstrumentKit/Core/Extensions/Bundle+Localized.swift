// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension Bundle {
    func localized(for languageCode: String) throws -> Bundle? {
        guard let path = self.path(forResource: languageCode, ofType: "lproj") else {
            throw LocalizationError.projectNotFound(languageCode)
        }

        return .init(path: path)
    }

    func localized(for locale: Locale) throws -> Bundle? {
        guard let languageCode = locale.languageCode else {
            throw LocalizationError.projectNotFound(locale)
        }

        return try self.localized(for: languageCode)
    }

    func localizedString(for locale: Locale = .current, key: String, value: String? = nil, table: String) -> String {
        let bundle = (try? self.localized(for: locale)) ?? self
        let localizedString = bundle.localizedString(forKey: key, value: value, table: table)

        // If our localized string matches the key, it means we didn't receive a localization.
        // Instead of returning the key, grab the default (English) localization.
        guard localizedString != key else {
            return self.localizedString(forKey: key, value: value, table: table)
        }

        return localizedString
    }
}
