// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct Note: Codable, Equatable, Hashable {
    public let noteClass: NoteClass
    public let octave: Int

    public init(_ noteClass: NoteClass, octave: Int) {
        self.noteClass = noteClass
        self.octave = octave
    }
}

// MARK: - Supporting Types

public enum NoteError: LocalizedError {
    case invalidOctave(String)

    public var errorDescription: String? {
        switch self {
        case let .invalidOctave(octave):
            return "Invalid octave '\(octave)'."
        }
    }
}

// MARK: - Extensions

public extension Note {
    func octaveLower() -> Self {
        .init(self.noteClass, octave: self.octave - 1)
    }

    func octaveHigher() -> Self {
        .init(self.noteClass, octave: self.octave + 1)
    }

    func halfStepLower() -> Self {
        .init(self.noteClass - 1, octave: self.octave)
    }

    func halfStepHigher() -> Self {
        .init(self.noteClass + 1, octave: self.octave)
    }

    func wholeStepLower() -> Self {
        .init(self.noteClass - 2, octave: self.octave)
    }

    func wholeStepHigher() -> Self {
        .init(self.noteClass + 2, octave: self.octave)
    }
}

extension Note: RawRepresentable {
    public var rawValue: String {
        "\(self.noteClass.name)\(self.octave)"
    }

    public init?(rawValue: String) {
        try? self.init(text: rawValue)
    }

    public init(text: String) throws {
        let semitoneName = try text.match(for: "[A-Za-z#]{1,2}")
        let noteClass = try NoteClass(name: semitoneName)

        let octaveString = try text.match(for: "[0-9]{1,2}")

        guard let octave = Int(octaveString) else {
            throw NoteError.invalidOctave(octaveString)
        }

        self.init(noteClass, octave: octave)
    }
}

extension Note: Identifiable {
    public var id: RawValue {
        self.rawValue
    }
}

extension Note: CustomStringConvertible {
    public var description: String {
        "\(self.noteClass.name)\(self.octave)"
    }
}

public extension Array where Element == Note {
    var description: String {
        self.map(\.description).joined(separator: " ")
    }

    init(rawValue: String) {
        self = rawValue
            .split(separator: " ")
            .compactMap { Note(rawValue: String($0)) }
    }
}

extension String {
    private enum MatchError: LocalizedError {
        case invalidMatchRange(NSRange)
        case matchNotFound(pattern: String, text: String)

        var errorDescription: String? {
            switch self {
            case let .invalidMatchRange(range):
                return "Invalid match range '\(range)'."
            case let .matchNotFound(pattern, text):
                return "Match for pattern '\(pattern)' in text '\(text)' not found."
            }
        }
    }

    func match(for pattern: String, range: NSRange? = nil) throws -> String {
        let range = range ?? NSRange(self.startIndex..., in: self)

        guard let firstMatch = try NSRegularExpression(pattern: pattern)
            .matches(in: self, range: range)
            .first else {
            throw MatchError.matchNotFound(pattern: pattern, text: self)
        }

        guard let matchRange = Range(firstMatch.range, in: self) else {
            throw MatchError.invalidMatchRange(firstMatch.range)
        }

        return String(self[matchRange])
    }
}

// MARK: - Convenience

// TODO: Optimize by making these values static so the math never takes too long. Realistically, though, how often are these used and how long does it take?
public extension Note {
    static func c(_ octave: Int) -> Self {
        .init(.c, octave: octave)
    }

    static func cSharp(_ octave: Int) -> Self {
        .init(.cSharp, octave: octave)
    }

    static func d(_ octave: Int) -> Self {
        .init(.d, octave: octave)
    }

    static func dSharp(_ octave: Int) -> Self {
        .init(.dSharp, octave: octave)
    }

    static func e(_ octave: Int) -> Self {
        .init(.e, octave: octave)
    }

    static func f(_ octave: Int) -> Self {
        .init(.f, octave: octave)
    }

    static func fSharp(_ octave: Int) -> Self {
        .init(.fSharp, octave: octave)
    }

    static func g(_ octave: Int) -> Self {
        .init(.g, octave: octave)
    }

    static func gSharp(_ octave: Int) -> Self {
        .init(.gSharp, octave: octave)
    }

    static func a(_ octave: Int) -> Self {
        .init(.a, octave: octave)
    }

    static func aSharp(_ octave: Int) -> Self {
        .init(.aSharp, octave: octave)
    }

    static func b(_ octave: Int) -> Self {
        .init(.b, octave: octave)
    }
}

// MARK: - Constants

public extension Note {
    // https://en.wikipedia.org/wiki/A440_(pitch_standard)
    static let standard: Self = .init(.a, octave: 4)
    static let lowest: Self = .init(.c, octave: 0)
    static let highest: Self = .init(.b, octave: 8)

    static let middleA: Self = .standard
    static let middleC: Self = .init(.c, octave: 4)

    static let inactiveNoteSymbol = "-"
}

// MARK: - Aliases

// TODO: Create and extend alias system?
// Source: https://www.liveabout.com/pitch-notation-and-octave-naming-2701389
// "All of the notes may be called out using these systems. F1 is also known as “contra F” or “double pedal F.”
// public extension Note {
//    static let triplePedalC: Self = .c(0)
//    static let doublePedalC: Self = .c(1)
//    static let pedalC: Self = .c(2)
//    static let bassC: Self = .c(3)
//    static let middleC: Self = .c(4)
//    static let trebleC: Self = .c(5)
//    static let topC: Self = .c(6)
//    static let doubleTopC: Self = .c(7)
//    static let doubleHighC: Self = .c(7)
//    static let tripleTopC: Self = .c(8)
//    static let tripleHighC: Self = .c(8)
// }

///// See [Scientific pitch notation](https://en.wikipedia.org/wiki/Scientific_pitch_notation).
/////
///// The guitar is a transposing instrument; that is, music for guitars is notated one octave higher than the true pitch.
///// This is to reduce the need for ledger lines in music written for the instrument, and thus simplify the reading of notes when playing the guitar.
// enum ScientificPitch: Float { ... }
