// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

public enum LocalizationError: LocalizedError {
    case projectNotFound(String)

    public var errorDescription: String? {
        switch self {
        case let .projectNotFound(languageCode):
            return "Localization project (.lproj) not found for locale '\(languageCode)'."
        }
    }

    public static func projectNotFound(_ locale: Locale) -> Self {
        .projectNotFound(locale.identifier)
    }
}
