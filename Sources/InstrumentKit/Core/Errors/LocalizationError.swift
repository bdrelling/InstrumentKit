// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public enum LocalizationError: LocalizedError {
    case projectNotFound(Locale)

    public var errorDescription: String? {
        switch self {
        case let .projectNotFound(locale):
            return "Localization project (.lproj) not found for locale '\(locale)'."
        }
    }
}
