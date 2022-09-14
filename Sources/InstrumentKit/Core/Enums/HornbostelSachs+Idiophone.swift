// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by vibrating the instrument itself, without the use of air flow, strings, membranes, or electricity.
    /// (eg. drums, xylophone, marimba, glockenspiel)
    ///
    /// For more information, see:
    ///   - [Idiophone](https://en.wikipedia.org/wiki/Idiophone)
    ///   - [Hornbostel-Sachs - Idiophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Idiophones_(1))
    ///   - [List of Idiophones](https://en.wikipedia.org/wiki/List_of_idiophones_by_Hornbostel–Sachs_number)
    enum Idiophone: Codable {
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
    enum Struck: String, Codable, CaseIterable {
        /// Idiophones directly struck by the player, whether by hands or intermediate device.
        case direct = "1"
        /// Idiophones which are not directly struck by the player, such as shaken instruments.
        case indirect = "2"
    }

    /// Idiophones which are set in vibration by being plucked.
    enum Plucked: String, Codable, CaseIterable {
        /// Idiophones with lamellae that vibrate within a frame or hoop.
        case frame = "1"
        /// Idiophones with lamellae that are tied to a board or cut out from a board like the teeth of a comb.
        case comb = "2"
        /// Idiophones with mixed sets of lamellae.
        case mixed = "3"
    }

    /// Idiophones which are set in vibration by being rubbed.
    enum Friction: String, Codable, CaseIterable {
        /// Idiophones with individual or sets of rubbed sticks.
        case sticks = "1"
        /// Idiophones with individual or sets of rubbed plaques.
        case plaques = "2"
        /// Idiophones with individual or sets of rubbed vessels.
        case vessels = "3"
        /// Idiophones with mixed sets of rubbed implements.
        case mixed = "4"
    }

    /// Idiophones which are set in vibration by the movement of air.
    enum Blown: String, Codable, CaseIterable {
        /// Idiophones with individual or sets of blown sticks.
        case sticks = "1"
        /// Idiophones with individual or sets of blown plaques.
        case plaques = "2"
        /// Idiophones with mixed sets of blown implements.
        case mixed = "3"
    }
}

// MARK: - Extensions

public extension HornbostelSachs.Idiophone {
    var rawValue: String {
        switch self {
        case let .struck(struck):
            return "1" + struck.rawValue
        case let .plucked(plucked):
            return "2" + plucked.rawValue
        case let .friction(friction):
            return "3" + friction.rawValue
        case let .blown(blown):
            return "4" + blown.rawValue
        case .unclassified:
            return "5"
        }
    }
}

extension HornbostelSachs.Idiophone: CaseIterable {
    public static var allCases: [Self] = [
        Struck.allCases.map { Self.struck($0) },
        Plucked.allCases.map { Self.plucked($0) },
        Friction.allCases.map { Self.friction($0) },
        Blown.allCases.map { Self.blown($0) },
        [.unclassified],
    ].flatMap { $0 }
}
