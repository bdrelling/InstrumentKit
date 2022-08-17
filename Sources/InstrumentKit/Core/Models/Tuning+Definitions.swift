// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Tuning {
    // The type names in this extension are lowercased for the sake of creating a prettier outward interface.
    enum Bass: Tuning, CaseIterable {
        case standard = "standard: E2 A2 D3 G3"
    }

    enum Guitar: Tuning, CaseIterable {
        case standard = "standard: E2 A2 D3 G3 B3 E4"
    }

    enum IrishBouzouki: Tuning, CaseIterable {
        case standard = "standard: G2 D3 A3 D4"
    }

    enum Ukulele: Tuning, CaseIterable {
        case standard = "standard: G4 C4 E4 A4"
    }
}

// MARK: - Extensions

extension Tuning: CaseIterable {
    // Instead of keeping a list in two places, just flatten the list of all tunings across all StringInstruments.
    public static var allCases = StringInstrument.allCases.flatMap(\.tunings)
}

extension Tuning: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    /// Initializes a `Tuning` using a `String` with the format `<localizationKey>: <notes>`.
    /// Example: `"standard: E2 A2 D3 G3 B3 E4"` defines a standard guitar tuning.
    public init(stringLiteral: String) {
        let components = stringLiteral.split(separator: ":")

        // Unless we have exactly two components, return an empty "error" tuning to indicate a failure.
        guard components.count == 2 else {
            // We add the stringLiteral value to the name to help identify the failure in tests.
            self.init(localizationKey: "error (\(stringLiteral))", notes: [])
            return
        }

        // Our first component is the localization key.
        let localizationKey = String(components[0])

        // Our second component is the array of notes.
        let notes = components[1].trimmingCharacters(in: .whitespaces)

        self.init(localizationKey: localizationKey, notes: .init(rawValue: notes))
    }
}
