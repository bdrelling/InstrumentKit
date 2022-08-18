// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

// Naming is hard.
// The following resources can help explain why:
//   - https://en.wikipedia.org/wiki/Pitch_class
//   - https://music.stackexchange.com/questions/32087/terminology-note-and-note-class
public struct PitchClass: Codable, Equatable, Hashable {
    public let name: String
    public let index: Int

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

    private init(_ name: String, index: Int) {
        self.name = name
        self.index = index
    }
}

// MARK: - Supporting Types

public enum PitchClassError: LocalizedError {
    case invalidName(String)
    case invalidSymbol(String)

    public var errorDescription: String? {
        switch self {
        case let .invalidName(name):
            return "Invalid pitchClass name '\(name)'."
        case let .invalidSymbol(symbol):
            return "Invalid pitchClass symbol '\(symbol)'."
        }
    }
}

// MARK: - Extensions

public extension PitchClass {
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

extension PitchClass: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.index < rhs.index
    }
}

extension PitchClass: CaseIterable {
    public static let allCases: [Self] = [.c, .cSharp, .d, .dSharp, .e, .f, .fSharp, .g, .gSharp, .a, .aSharp, .b]
}

extension PitchClass: Identifiable {
    public var id: RawValue {
        self.rawValue
    }
}

extension PitchClass: CustomStringConvertible {
    public var description: String {
        self.name
    }
}

extension PitchClass: RawRepresentable {
    public var rawValue: Int {
        self.index
    }

    public init(rawValue: Int) {
        var index = rawValue % PitchClass.allCases.count

        // If the index is negative, we need to subtract the index from the count to get the equivalent positive index.
        if index < 0 {
            index = PitchClass.allCases.count - abs(index)
        }

        self = PitchClass.allCases[index]
    }
}

public extension PitchClass {
    init(name: String) throws {
        guard name.count >= 1 else {
            throw PitchClassError.invalidName(name)
        }

        // Get the first character and uppercase it.
        let letter = name.prefix(1).uppercased()
        var firstMatch: PitchClass?

        if name.count == 1 {
            // If our name is a single character, return the first match by the letter.
            firstMatch = Self.allCases.first(where: { $0.name == letter })
        } else if name.count == 2 {
            // If our name is two characters, we need to get the symbol and match both.

            // Normalize the name to ensure it will match the pitchClass names.
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
                throw PitchClassError.invalidSymbol(symbol)
            }
        }

        if let pitchClass = firstMatch {
            self = pitchClass
        } else {
            throw PitchClassError.invalidName(name)
        }
    }
}

// MARK: - Convenience

public extension PitchClass {
    /// https://en.wikipedia.org/wiki/pitchClass#Equal_temperament
    /// 12-tone equal temperament is a form of meantone tuning in which the diatonic and chromatic pitchClasses are exactly the same, because its circle of fifths has no break. Each pitchClass is equal to one twelfth of an octave.
    /// This is a ratio of 2^1/12 (approximately 1.05946), or 100 cents, and is 11.7 cents narrower than the 16:15 ratio (its most common form in just intonation, discussed below).
//    static let intervalRatio: Float = 1.059463094359

    static let c: Self = .init("C", index: 0)
    static let cSharp: Self = .init("C#", index: 1)
    static let d: Self = .init("D", index: 2)
    static let dSharp: Self = .init("D#", index: 3)
    static let e: Self = .init("E", index: 4)
    static let f: Self = .init("F", index: 5)
    static let fSharp: Self = .init("F#", index: 6)
    static let g: Self = .init("G", index: 7)
    static let gSharp: Self = .init("G#", index: 8)
    static let a: Self = .init("A", index: 9)
    static let aSharp: Self = .init("A#", index: 10)
    static let b: Self = .init("B", index: 11)
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
