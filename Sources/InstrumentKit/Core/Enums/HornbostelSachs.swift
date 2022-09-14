/// A type-safe enum representing the Hornbostel-Sachs classification system for instruments.
/// This enum only accounts for the first three levels of classification.
///
/// Source: <https://en.wikipedia.org/wiki/Hornbostel–Sachs>
public enum HornbostelSachs: Codable {
    case idiophone(Idiophone)
    case membranophone(Membranophone)
    case chordophone(Chordophone)
    case aerophone(Aerophone)
    case electrophone(Electrophone)
}

// MARK: - Extensions

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
        }
    }
}

public extension Array where Element == HornbostelSachs {
    var description: String {
        self.map(\.description).joined(separator: ", ")
    }
}
