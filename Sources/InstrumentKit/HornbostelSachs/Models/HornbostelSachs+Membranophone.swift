// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by vibrating a stretched membrane.
    /// (eg. snare drums, kazoos)
    ///
    /// For more information, see:
    ///   - [Membranophone](https://en.wikipedia.org/wiki/Membranophone)
    ///   - [Hornbostel-Sachs - Membranophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Membranophones_(2))
    ///   - [List of Membranophones](https://en.wikipedia.org/wiki/List_of_membranophones_by_Hornbostel–Sachs_number)
    enum Membranophone {
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
    enum Struck: String, HornbostelSachsClassifying {
        /// Membranophones in which the membrane is struck directly, such as through bare hands, beaters or keyboards.
        case direct = "211"
        /// Membranophones which are shaken (ie. indirectly struck), resulting in the membrane being vibrated by objects inside the drum.
        case shaken = "212"
    }

    /// Membranophones in which the membrane vibrates as a result of friction.
    enum Friction: String, HornbostelSachsClassifying {
        /// Membranophones in which the membrane is vibrated from a stick that is rubbed or used to rub the membrane.
        case stick = "231"
        /// Membranophones in which a cord, attached to the membrane, is rubbed.
        case cord = "232"
        /// Membranophones in which the membrane is rubbed by hand.
        case hand = "233"
    }

    /// Membranophones which do not produce sound of their own, but modify other sounds by way of a vibrating membrane.
    enum Singing: String, HornbostelSachsClassifying {
        /// Membranophones in which the membrane is vibrated by an unbroken column of wind, without a chamber
        case free = "241"
        /// Membranophones in which the membrane is placed in a box, tube or other container.
        case tube = "242"
    }
}

// MARK: - Extensions

extension HornbostelSachs.Membranophone: HornbostelSachsClassifying {
    public var rawValue: String {
        switch self {
        case let .struck(struck):
            return struck.rawValue
        case .plucked:
            return "22"
        case let .friction(friction):
            return friction.rawValue
        case let .singing(singing):
            return singing.rawValue
        case .unclassified:
            return "25"
        }
    }

    public static var allCases: [Self] = [
        Struck.allCases.map { Self.struck($0) },
        [.plucked],
        Friction.allCases.map { Self.friction($0) },
        Singing.allCases.map { Self.singing($0) },
        [.unclassified],
    ].flatMap { $0 }.sorted()
}
