// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

enum InstrumentKitError: LocalizedError {
    case invalidInstrument(LocalizedInstrumentName)
    case invalidTuning(LocalizedTuningName)

    var errorDescription: String? {
        switch self {
        case let .invalidInstrument(name):
            return "Invalid instrument '\(name)'."
        case let .invalidTuning(name):
            return "Invalid tuning '\(name)'."
        }
    }
}
