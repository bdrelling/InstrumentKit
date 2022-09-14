// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by vibrating the instrument itself, without the use of air flow, strings, membranes, or electricity.
    /// (eg. drums, xylophone, marimba, glockenspiel)
    ///
    /// For more information, see:
    ///   - [Idiophone](https://en.wikipedia.org/wiki/Idiophone)
    ///   - [Hornbostel-Sachs - Idiophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Idiophones_(1))
    ///   - [List of Idiophones](https://en.wikipedia.org/wiki/List_of_idiophones_by_Hornbostel–Sachs_number)
    enum Idiophone {
        /// Idiophones which are set in vibration by being struck.
        case struck(Struck)
        /// Idiophones which are set in vibration by being plucked.
        case plucked(Plucked)
        /// Idiophones which are set in vibration by being rubbed.
        case friction(Friction)
        /// Idiophones which are set in vibration by the movement of air.
        case blown(Blown)
        /// Idiophones without an exact classification.
        case unclassified
    }
}

// MARK: - Supporting Types

public extension HornbostelSachs.Idiophone {
    /// Idiophones which are set in vibration by being struck.
    enum Struck: String, HornbostelSachsClassifying {
        /// Idiophones directly struck by the player, whether by hands or intermediate device.
        case direct = "111"
        /// Idiophones which are not directly struck by the player, such as shaken instruments.
        case indirect = "112"
    }

    /// Idiophones which are set in vibration by being plucked.
    enum Plucked: String, HornbostelSachsClassifying {
        /// Idiophones with lamellae that vibrate within a frame or hoop.
        case frame = "121"
        /// Idiophones with lamellae that are tied to a board or cut out from a board like the teeth of a comb.
        case comb = "122"
        /// Idiophones with mixed sets of lamellae.
        case mixed = "123"
    }

    /// Idiophones which are set in vibration by being rubbed.
    enum Friction: String, HornbostelSachsClassifying {
        /// Idiophones with individual or sets of rubbed sticks.
        case sticks = "131"
        /// Idiophones with individual or sets of rubbed plaques.
        case plaques = "132"
        /// Idiophones with individual or sets of rubbed vessels.
        case vessels = "133"
        /// Idiophones with mixed sets of rubbed implements.
        case mixed = "134"
    }

    /// Idiophones which are set in vibration by the movement of air.
    enum Blown: String, HornbostelSachsClassifying {
        /// Idiophones with individual or sets of blown sticks.
        case sticks = "141"
        /// Idiophones with individual or sets of blown plaques.
        case plaques = "142"
        /// Idiophones with mixed sets of blown implements.
        case mixed = "143"
    }
}

// MARK: - Extensions

extension HornbostelSachs.Idiophone: HornbostelSachsClassifying {
    public var rawValue: String {
        switch self {
        case let .struck(struck):
            return struck.rawValue
        case let .plucked(plucked):
            return plucked.rawValue
        case let .friction(friction):
            return friction.rawValue
        case let .blown(blown):
            return blown.rawValue
        case .unclassified:
            return "15"
        }
    }

    public static var allCases: [Self] = [
        Struck.allCases.map { Self.struck($0) },
        Plucked.allCases.map { Self.plucked($0) },
        Friction.allCases.map { Self.friction($0) },
        Blown.allCases.map { Self.blown($0) },
        [.unclassified],
    ].flatMap { $0 }.sorted()
}
