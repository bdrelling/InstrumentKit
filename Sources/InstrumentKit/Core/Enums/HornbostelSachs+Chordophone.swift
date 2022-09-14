// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by vibrating strings stretched between fixed points.
    /// (eg. guitars, harps, lutes, zithers, pianos, harpsichords)
    ///
    /// For more information, see:
    ///   - [Chordophone](https://en.wikipedia.org/wiki/Chordophone)
    ///   - [Hornbostel-Sachs - Chordophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Chordophones_(3))
    ///   - [List of Chordophones](https://en.wikipedia.org/wiki/List_of_chordophones_by_Hornbostel–Sachs_number)
    enum Chordophone: Codable {
        /// Chordophones that are simply a string or strings with a string bearer, in which a resonator is optional.
        case simple(Simple)
        /// Chordophones in which the resonator is an integral part of the instrument.
        case composite(Composite)
        /// Chordophones without an exact classification.
        case unclassified
    }
}

// MARK: - Supporting Types

public extension HornbostelSachs.Chordophone {
    /// Chordophones that are simply a string or strings with a string bearer, in which a resonator is optional.
    enum Simple: String, Codable, CaseIterable {
        /// Chordophones with a bar-shaped string bearer.
        case bar = "1"
        /// Chordophones with a tube-shaped string bearer.
        case tube = "2"
        /// Chordophones composed of canes tied together in the manner of a raft.
        case raft = "3"
        /// Chordophones with a board-shaped string bearer.
        case board = "4"
        /// Chordophones with strings stretched across the mouth of a trough.
        case trough = "5"
        /// Chordophones with strings stretched across an open frame.
        case frame = "6"
    }

    /// Chordophones in which the resonator is an integral part of the instrument.
    enum Composite: String, Codable, CaseIterable {
        /// Chordophones in which the plane of the strings runs parallel with the resonator's surface.
        case lute = "1"
        /// Chordophones in which the plane of the strings runs perpendicular to the resonator's surface.
        case harp = "2"
        /// Chordophones in which the plane of the strings runs at a right-angle to the resonator's surface.
        case harpLute = "3"
    }
}

// MARK: - Extensions

public extension HornbostelSachs.Chordophone {
    var rawValue: String {
        switch self {
        case let .simple(simple):
            return "1" + simple.rawValue
        case let .composite(composite):
            return "2" + composite.rawValue
        case .unclassified:
            return "3"
        }
    }
}

extension HornbostelSachs.Chordophone: CaseIterable {
    public static var allCases: [Self] = [
        Simple.allCases.map { Self.simple($0) },
        Composite.allCases.map { Self.composite($0) },
        [.unclassified],
    ].flatMap { $0 }
}
