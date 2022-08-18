// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

enum NoteMathError: Error {
    case invalidFrequency(Float)
}

// MARK: - Extensions

extension NoteMathError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .invalidFrequency(frequency):
            return "Frequency of \(frequency) Hz is invalid for calculations."
        }
    }
}
