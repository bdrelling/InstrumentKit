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
        // The standard tuning should be first when sorting, followed by alphabetical order.
        if lhs.localizationKey == Self.defaultTuningKey {
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

public extension Tuning {
    func closestNote(to frequency: Float) -> Note? {
        self.notes.closest(to: frequency)
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
