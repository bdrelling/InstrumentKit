/// A partial enum for defining Hornbostel-Sachs Classification codes.
/// Suffixes, such as those for classifications 321.321 and 321.322, are excluded from this enum.
///
/// Sources:
/// - <https://en.wikipedia.org/wiki/Hornbostel–Sachs>
public enum HornbostelSachsClassification: String, Codable {
    case spikeBoxLute = "321.312"
    case neckedBowlLute = "321.321"
    case neckedBoxLute = "321.322"
    case frameHarpWithManualTuningAction = "322.221"
    case frameHarpWithPedalTuningAction = "322.222"
}

// MARK: - Extensions

extension HornbostelSachsClassification: CustomStringConvertible {
    public var description: String {
        self.rawValue
    }
}

public extension Array where Element == HornbostelSachsClassification {
    var description: String {
        self.map(\.description).joined(separator: ", ")
    }
}
