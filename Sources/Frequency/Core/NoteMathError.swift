import Foundation
import Tonic

// MARK: - Supporting Types

public enum NoteMathError: LocalizedError {
    case invalidFrequency(Float)
    case outsideOfAuditoryRange(Note)

    public var errorDescription: String? {
        switch self {
        case let .invalidFrequency(frequency):
            return "Frequency '\(frequency)' is invalid."
        case let .outsideOfAuditoryRange(note):
            return "Note '\(note)' is invalid; it is outside of the perceptible auditory range."
        }
    }
}
