// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by vibrating air flow, without the use of strings or membranes.
    /// (eg. accordions, harmonicas, flutes, trumpets, wind instruments)
    ///
    /// For more information, see:
    ///   - [Aerophone](https://en.wikipedia.org/wiki/Aerophone)
    ///   - [Hornbostel-Sachs - Aerophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Aerophones_(4))
    ///   - [List of Aerophones](https://en.wikipedia.org/wiki/List_of_aerophones_by_Hornbostel–Sachs_number)
    enum Aerophone: Codable {
        /// Aerophones in which vibrating air is not contained within the instrument.
        case free(Free)
        /// Aerophones in which vibrating air is contained within the instrument.
        case nonFree(NonFree)
        /// Aerophones in which the methods of interaction varies.
        case mixed
    }
}

// MARK: - Supporting Types

public extension HornbostelSachs.Aerophone {
    /// Aerophones in which vibrating air is not contained within the instrument.
    enum Free: String, Codable, CaseIterable {
        /// Aerophones in which the airflow meets a sharp edge, or a sharp edge is moved through the air.
        case displacementFree = "1"
        /// Aerophones in which the airflow is interrupted periodically.
        case interruptiveFree = "2"
        /// Aerophones in which the sound is caused by a single compression and release of air.
        case plosive = "3"
        /// Aerophones in which the methods of interacting with the airflow varies.
        case mixed = "4"
    }

    /// Aerophones in which vibrating air is contained within the instrument.
    enum NonFree: String, Codable, CaseIterable {
        /// Aerophones in which the player makes a ribbon-shaped flow of air with their lips, or their breath is directed through a duct against an edge.
        case edgeBlown = "1"
        /// Aerophones in which the player's breath is directed against a lamella or pair of lamellae which periodically nterrupt the airflow.
        case reed = "2"
        /// Aerophones in which the player's vibrating lips set the air in motion.
        case trumpet = "3"
        /// Aerophones in which the methods of interacting with the airflow varies.
        case mixed = "4"
    }
}

// MARK: - Extensions

public extension HornbostelSachs.Aerophone {
    var rawValue: String {
        switch self {
        case let .free(free):
            return "1" + free.rawValue
        case let .nonFree(nonFree):
            return "2" + nonFree.rawValue
        case .mixed:
            return "3"
        }
    }
}

extension HornbostelSachs.Aerophone: CaseIterable {
    public static var allCases: [Self] = [
        Free.allCases.map { Self.free($0) },
        NonFree.allCases.map { Self.nonFree($0) },
        [.mixed],
    ].flatMap { $0 }
}
