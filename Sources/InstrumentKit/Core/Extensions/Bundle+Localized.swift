// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension Bundle {
    func localized(for locale: Locale) -> Bundle? {
        if let languageCode = locale.languageCode {
            return self.localized(for: languageCode)
        } else {
            return nil
        }
    }

    func localized(for language: String) -> Bundle? {
        guard let path = self.path(forResource: language, ofType: "lproj") else {
            return nil
        }

        return .init(path: path)
    }
}
