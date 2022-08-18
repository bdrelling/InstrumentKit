// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import NoteKit

public struct Tuning {
    private static let localizationTableName = "Tunings"
    private static let defaultTuningKey = "standard"

    public let localizationKey: String
    public let name: String
    public let notes: [Note]

    /// The locale used to fetch this instance's localized `String` values.
    /// This property is primarily used for testing and validation.
    public private(set) var locale: Locale?

    private init(localizationKey: String, locale: Locale?, name: String, notes: [Note]) {
        self.localizationKey = localizationKey
        self.locale = locale
        self.name = name
        self.notes = notes
    }

    public init(localizationKey: String, locale: Locale = .current, notes: [Note]) {
        let name = Bundle.module.localizedString(for: locale, key: localizationKey, table: Self.localizationTableName)

        self.init(localizationKey: localizationKey, locale: locale, name: name, notes: notes)
    }

    public init(localizationKey: String, locale: Locale = .current, notes: Note...) {
        self.init(localizationKey: localizationKey, locale: locale, notes: notes)
    }

    /// Creates an unlocalized and unlocalizable instance, typically for purposes like mocking.
    public init(name: String, notes: [Note]) {
        self.init(localizationKey: name, locale: nil, name: name, notes: notes)
    }
}

// MARK: - Extensions

public extension Tuning {
    func closestNote(to frequency: Float) -> Note? {
        self.notes.closest(to: frequency)
    }
}

extension Tuning: Codable {
    enum CodingKeys: String, CodingKey {
        case localizationKey
        case name
        case notes
    }
}

extension Tuning: Equatable, Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localizationKey == rhs.localizationKey
            && lhs.notes == rhs.notes
    }
}

extension Tuning: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        // Prioritize standard tunings.
        // In the event the localization keys match, sort by name.
        if lhs.localizationKey != rhs.localizationKey, lhs.localizationKey == Self.defaultTuningKey {
            return true
        } else {
            return lhs.name < rhs.name
        }
    }
}

extension Tuning: Identifiable {
    public var id: String {
        self.localizationKey
    }
}

extension Tuning: CustomStringConvertible {
    public var description: String {
        "\(self.name): \(self.notes.description)"
    }
}

extension Tuning: Localizable {
    public func localized(to locale: Locale) -> Self {
        .init(
            localizationKey: self.localizationKey,
            locale: locale,
            notes: self.notes
        )
    }
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

public extension RawRepresentable where Self: CaseIterable, Self.RawValue == Tuning {
    static var allTunings: [Self.RawValue] { Self.allCases.map(\.rawValue) }
}

// MARK: - Convenience

extension Tuning {
    static func standard(_ notes: [Note]) -> Self {
        .init(localizationKey: Self.defaultTuningKey, notes: notes)
    }

    static func standard(_ notes: Note...) -> Self {
        .standard(notes)
    }
}
