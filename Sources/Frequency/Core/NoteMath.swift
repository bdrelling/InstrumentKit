// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

public final class NoteMath {}

// MARK: - Constants

public extension NoteMath {
    static let semitonesPerOctave = 12
    static let centsPerOctave: Float = 1200
    static let standardPitchClass = "A"
    static let standardOctave = 4
    static let lowestPitchClass = "C"
    static let lowestOctave = 0
    static let standardNoteFrequency: Float = 440
    static let baseNoteFrequency: Float = 440
    static let precision: Float = 100.0
}

// MARK: - Supporting Types

public enum NoteMathError: LocalizedError {
    case invalidFrequency(Float)

    public var errorDescription: String? {
        switch self {
        case let .invalidFrequency(frequency):
            return "Frequency '\(frequency)' is invalid."
        }
    }
}

// MARK: - Extensions

public extension NoteMath {
    // MARK: Half Step Interval

    static func interval(from frequency: Float, to referenceFrequency: Float) throws -> Int {
        guard frequency > 0 else {
            throw NoteMathError.invalidFrequency(frequency)
        }

        guard referenceFrequency > 0 else {
            throw NoteMathError.invalidFrequency(referenceFrequency)
        }

        let numberOfPitchClasss = Float(Self.semitonesPerOctave)
        return Int(round(numberOfPitchClasss * log2f(frequency / referenceFrequency)))
    }

    static func standardIntervalForFrequency(_ frequency: Float) throws -> Int {
        try self.interval(from: frequency, to: Self.standardNoteFrequency)
    }

    static func baseIntervalForFrequency(_ frequency: Float) throws -> Int {
        try self.interval(from: frequency, to: Self.baseNoteFrequency)
    }

    // MARK: Frequency

    static func frequencyForInterval(_ interval: Int) -> Float {
        // Multiply the frequency by 2^(n/12), where n is the number of half-steps away from the reference note.
        let power = Float(interval) / Float(Self.semitonesPerOctave)
        let frequency = Self.standardNoteFrequency * powf(2, power)

        return round(frequency * Self.precision) / Self.precision
    }

    // MARK: Cents

    static func cents(from fromFrequency: Float, to toFrequency: Float) -> Float {
        let centsPerOctave = Float(Self.semitonesPerOctave * 100)
        return centsPerOctave * log2f(toFrequency / fromFrequency)
    }

    // MARK: Octave

    static func octaveForInterval(_ interval: Int) -> Int {
        let count = Self.semitonesPerOctave
        let resNegativeIndex = Self.standardOctave - (abs(interval) + 2) / count
        let resPositiveIndex = Self.standardOctave + (interval + 9) / count

        return interval < 0
            ? resNegativeIndex
            : resPositiveIndex
    }

    static func octaveForFrequency(_ frequency: Float) throws -> Int {
        let interval = try self.standardIntervalForFrequency(frequency)
        return self.octaveForInterval(interval)
    }
}
