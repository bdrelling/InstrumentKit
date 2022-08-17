// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

// Naming this struct was hard.
// See: https://music.stackexchange.com/questions/32087/terminology-note-and-note-class
public struct NoteClass: Codable, Equatable, Hashable {
    public let name: String
    public let index: Int
    public let frequency: Float

    public var isSharp: Bool {
        switch self {
        case .cSharp, .dSharp, .fSharp, .gSharp, .aSharp:
            return true
        default:
            return false
        }
    }

    public var nameWithFlats: String {
        switch self {
        case .cSharp:
            return "Db"
        case .dSharp:
            return "Eb"
        case .fSharp:
            return "Gb"
        case .gSharp:
            return "Ab"
        case .aSharp:
            return "Bb"
        default:
            return self.name
        }
    }

    private init(_ name: String, index: Int, frequency: Float) {
        self.name = name
        self.index = index
        self.frequency = frequency
    }
}

// MARK: - Supporting Types

public enum NoteClassError: LocalizedError {
    case invalidName(String)
    case invalidSymbol(String)

    public var errorDescription: String? {
        switch self {
        case let .invalidName(name):
            return "Invalid noteClass name '\(name)'."
        case let .invalidSymbol(symbol):
            return "Invalid noteClass symbol '\(symbol)'."
        }
    }
}

// MARK: - Extensions

public extension NoteClass {
    func previous() -> Self? {
        Self.allCases.before(self, loop: true)
    }

    func next() -> Self? {
        Self.allCases.after(self, loop: true)
    }

    func lower() -> Self? {
        Self.allCases.before(self)
    }

    func higher() -> Self? {
        Self.allCases.after(self)
    }

    static func + (lhs: Self, rhs: Int) -> Self {
        .init(rawValue: lhs.rawValue + rhs)
    }

    static func - (lhs: Self, rhs: Int) -> Self {
        .init(rawValue: lhs.rawValue - rhs)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        lhs + rhs.rawValue
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        lhs - rhs.rawValue
    }
}

extension NoteClass: CaseIterable {
    public static let allCases: [Self] = [.c, .cSharp, .d, .dSharp, .e, .f, .fSharp, .g, .gSharp, .a, .aSharp, .b]
    public static let allFrequencies = Self.allCases.map(\.frequency)
}

extension NoteClass: Identifiable {
    public var id: RawValue {
        self.rawValue
    }
}

extension NoteClass: CustomStringConvertible {
    public var description: String {
        self.name
    }
}

extension NoteClass: RawRepresentable {
    public var rawValue: Int {
        self.index
    }

    public init(rawValue: Int) {
        var index = rawValue % NoteClass.allCases.count

        // If the index is negative, we need to subtract the index from the count to get the equivalent positive index.
        if index < 0 {
            index = NoteClass.allCases.count - abs(index)
        }

        self = NoteClass.allCases[index]
    }
}

public extension NoteClass {
    init(name: String) throws {
        guard name.count >= 1 else {
            throw NoteClassError.invalidName(name)
        }

        // Get the first character and uppercase it.
        let letter = name.prefix(1).uppercased()
        var firstMatch: NoteClass?

        if name.count == 1 {
            // If our name is a single character, return the first match by the letter.
            firstMatch = Self.allCases.first(where: { $0.name == letter })
        } else if name.count == 2 {
            // If our name is two characters, we need to get the symbol and match both.

            // Normalize the name to ensure it will match the noteClass names.
            // This allows us to pass in any valid symbols: #, ♯, b, ♭
            let symbol = name.suffix(1)
                .replacingOccurrences(of: "♯", with: "#")
                .replacingOccurrences(of: "♭", with: "b")

            let stylizedName = "\(letter)\(symbol)"

            switch symbol {
            case "#":
                firstMatch = Self.allCases.first(where: { $0.name == stylizedName })
            case "b":
                firstMatch = Self.allCases.first(where: { $0.nameWithFlats == stylizedName })
            default:
                throw NoteClassError.invalidSymbol(symbol)
            }
        }

        if let noteClass = firstMatch {
            self = noteClass
        } else {
            throw NoteClassError.invalidName(name)
        }
    }
}

// MARK: - Convenience

public extension NoteClass {
    // The total number of semitones in an octave.
    // This value should always be 12, but we'll calculate it from the array count for good measure.
    // To avoid using the array count every time we need it, which will be quite often with music math calculations,
    // we'll store this as a constant.
    static let count: Int = Self.allCases.count

    /// https://en.wikipedia.org/wiki/noteClass#Equal_temperament
    /// 12-tone equal temperament is a form of meantone tuning in which the diatonic and chromatic noteClasses are exactly the same, because its circle of fifths has no break. Each noteClass is equal to one twelfth of an octave.
    /// This is a ratio of 2^1/12 (approximately 1.05946), or 100 cents, and is 11.7 cents narrower than the 16:15 ratio (its most common form in just intonation, discussed below).
//    static let intervalRatio: Float = 1.059463094359

    static let c: Self = .init("C", index: 0, frequency: 16.35)
    static let cSharp: Self = .init("C#", index: 1, frequency: 17.32)
    static let d: Self = .init("D", index: 2, frequency: 18.35)
    static let dSharp: Self = .init("D#", index: 3, frequency: 19.45)
    static let e: Self = .init("E", index: 4, frequency: 20.60)
    static let f: Self = .init("F", index: 5, frequency: 21.83)
    static let fSharp: Self = .init("F#", index: 6, frequency: 23.12)
    static let g: Self = .init("G", index: 7, frequency: 24.50)
    static let gSharp: Self = .init("G#", index: 8, frequency: 25.96)
    static let a: Self = .init("A", index: 9, frequency: 27.50)
    static let aSharp: Self = .init("A#", index: 10, frequency: 29.14)
    static let b: Self = .init("B", index: 11, frequency: 30.87)
}

// Engineering Toolbox
// https://www.engineeringtoolbox.com/note-frequencies-d_520.html

// E2 = 82.41
// A2 = 110.0
// D3 = 146.8
// G3 = 196.0
// B3 = 246.9
// E4 = 329.6

// Wikipedia
// https://en.wikipedia.org/wiki/Guitar_tunings#Standard

// E2 = 82.41
// A2 = 110.00
// D3 = 146.83
// G3 = 196.0
// B3 = 246.94
// E4 = 329.63
