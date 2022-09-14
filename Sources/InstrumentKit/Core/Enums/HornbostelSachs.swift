/// A type-safe enum representing the Hornbostel-Sachs classification system for instruments.
/// This enum only accounts for the first three levels of classification.
///
/// For more information, see:
///   - [Hornbostel-Sachs](https://en.wikipedia.org/wiki/Hornbostel–Sachs)
///   - [Hornbostel-Sachs Classification of Musical Instruments](https://www.isko.org/cyclo/hornbostel.htm)
public indirect enum HornbostelSachs: Codable {
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

extension HornbostelSachs: CustomStringConvertible {
    public var description: String {
        self.rawValue
    }
}

public extension HornbostelSachs {
    var rawValue: String {
        switch self {
        case let .idiophone(idiophone):
            return "1" + idiophone.rawValue
        case let .membranophone(membranophone):
            return "2" + membranophone.rawValue
        case let .chordophone(chordophone):
            return "3" + chordophone.rawValue
        case let .aerophone(aerophone):
            return "4" + aerophone.rawValue
        case let .electrophone(electrophone):
            return "5" + electrophone.rawValue
        case let .composite(classifications):
            return classifications.rawValue
        }
    }
}

extension HornbostelSachs: CaseIterable {
    public static var allCases: [Self] = [
        Idiophone.allCases.map { Self.idiophone($0) },
        Membranophone.allCases.map { Self.membranophone($0) },
        Chordophone.allCases.map { Self.chordophone($0) },
        Aerophone.allCases.map { Self.aerophone($0) },
        Electrophone.allCases.map { Self.electrophone($0) },
    ].flatMap { $0 }
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
