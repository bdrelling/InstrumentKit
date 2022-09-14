// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by vibrating a stretched membrane.
    /// (eg. snare drums, kazoos)
    ///
    /// For more information, see:
    ///   - [Membranophone](https://en.wikipedia.org/wiki/Membranophone)
    ///   - [Hornbostel-Sachs - Membranophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Membranophones_(2))
    ///   - [List of Membranophones](https://en.wikipedia.org/wiki/List_of_membranophones_by_Hornbostel–Sachs_number)
    enum Membranophone: Codable {
        /// Membranophones which have a struck membrane.
        case struck(Struck)
        /// Membranophones with a string attached to the membrane, so that when the string is plucked, the membrane vibrates.
        case plucked
        /// Membranophones in which the membrane vibrates as a result of friction.
        case friction(Friction)
        /// Membranophones which do not produce sound of their own, but modify other sounds by way of a vibrating membrane.
        case singing(Singing)
        /// Membranophones without an exact classification.
        case unclassified
    }
}

// MARK: - Supporting Types

public extension HornbostelSachs.Membranophone {
    /// Membranophones which have a struck membrane.
    enum Struck: String, Codable, CaseIterable {
        /// Membranophones in which the membrane is struck directly, such as through bare hands, beaters or keyboards.
        case direct = "1"
        /// Membranophones which are shaken (ie. indirectly struck), resulting in the membrane being vibrated by objects inside the drum.
        case shaken = "2"
    }

    /// Membranophones in which the membrane vibrates as a result of friction.
    enum Friction: String, Codable, CaseIterable {
        /// Membranophones in which the membrane is vibrated from a stick that is rubbed or used to rub the membrane.
        case stick = "1"
        /// Membranophones in which a cord, attached to the membrane, is rubbed.
        case cord = "2"
        /// Membranophones in which the membrane is rubbed by hand.
        case hand = "3"
    }

    /// Membranophones which do not produce sound of their own, but modify other sounds by way of a vibrating membrane.
    enum Singing: String, Codable, CaseIterable {
        /// Membranophones in which the membrane is vibrated by an unbroken column of wind, without a chamber
        case free = "1"
        /// Membranophones in which the membrane is placed in a box, tube or other container.
        case tube = "2"
    }
}

// MARK: - Extensions

public extension HornbostelSachs.Membranophone {
    var rawValue: String {
        switch self {
        case let .struck(struck):
            return "1" + struck.rawValue
        case .plucked:
            return "2"
        case let .friction(friction):
            return "3" + friction.rawValue
        case let .singing(singing):
            return "4" + singing.rawValue
        case .unclassified:
            return "5"
        }
    }
}

extension HornbostelSachs.Membranophone: CaseIterable {
    public static var allCases: [Self] = [
        Struck.allCases.map { Self.struck($0) },
        [.plucked],
        Friction.allCases.map { Self.friction($0) },
        Singing.allCases.map { Self.singing($0) },
        [.unclassified],
    ].flatMap { $0 }
}
