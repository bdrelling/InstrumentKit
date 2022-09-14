/// A type-safe enum representing the Hornbostel-Sachs classification system for instruments.
/// This enum only accounts for the first three levels of classification.
///
/// For more information, see:
///   - [Hornbostel-Sachs](https://en.wikipedia.org/wiki/Hornbostel–Sachs)
///   - [Hornbostel-Sachs Classification of Musical Instruments](https://www.isko.org/cyclo/hornbostel.htm)
public indirect enum HornbostelSachs {
    /// An instrument that produces sound by vibrating the instrument itself, without the use of air flow, strings, membranes, or electricity.
    case idiophone(Idiophone)
    /// An instrument that produces sound by vibrating a stretched membrane.
    case membranophone(Membranophone)
    /// An instrument that produces sound by vibrating strings stretched between fixed points.
    case chordophone(Chordophone)
    /// An instrument that produces sound by vibrating air flow, without the use of strings or membranes.
    case aerophone(Aerophone)
    /// An instrument that produces sound by electricity.
    case electrophone(Electrophone)
    /// An instrument that can be classified within multiple Hornbostel-Sachs classifications.
    /// Composite classifications are rarely used.
    case composite([HornbostelSachs])
}

// MARK: - Extensions

public extension HornbostelSachs {
    /// An instrument that can be classified within multiple Hornbostel-Sachs classifications
    ///
    /// This is a convenience function for creating a composite classification using a variadic parametet array.
    static func composite(_ classifications: HornbostelSachs...) -> Self {
        .composite(classifications)
    }
}

extension HornbostelSachs: HornbostelSachsClassifying {
    public var rawValue: String {
        switch self {
        case let .idiophone(idiophone):
            return idiophone.rawValue
        case let .membranophone(membranophone):
            return membranophone.rawValue
        case let .chordophone(chordophone):
            return chordophone.rawValue
        case let .aerophone(aerophone):
            return aerophone.rawValue
        case let .electrophone(electrophone):
            return electrophone.rawValue
        case let .composite(classifications):
            return classifications.rawValue
        }
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        if case .composite = lhs {
            // Composite classifications are always last.
            return false
        } else if case .composite = rhs {
            // Composite classifications are always last.
            return true
        } else {
            return lhs.rawValue < rhs.rawValue
        }
    }

    public static var allCases: [Self] = [
        Idiophone.allCases.map { Self.idiophone($0) },
        Membranophone.allCases.map { Self.membranophone($0) },
        Chordophone.allCases.map { Self.chordophone($0) },
        Aerophone.allCases.map { Self.aerophone($0) },
        Electrophone.allCases.map { Self.electrophone($0) },
    ].flatMap { $0 }.sorted()
}

public extension Array where Element == HornbostelSachs {
    var rawValue: String {
        /// Multple Hornbostel-Sachs classifications are represented by combining them with a `+` as the delimeter.
        self.map(\.rawValue).joined(separator: "+")
    }

    var description: String {
        self.rawValue
    }
}
