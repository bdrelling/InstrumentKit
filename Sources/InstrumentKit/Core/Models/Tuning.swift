// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import NoteKit

public struct Tuning: Codable, Hashable {
    private static let localizationTableName = "Tunings"
    private static let defaultTuningKey = "standard"

    public let localizationKey: String
    public let locale: Locale
    public let name: String
    public let notes: [Note]

    private init(localizationKey: String, locale: Locale = .current, name: String, notes: [Note]) {
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

    public init(name: String, notes: [Note]) {
        self.init(localizationKey: name, name: name, notes: notes)
    }
}

// MARK: - Extensions

extension Tuning: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localizationKey == rhs.localizationKey
            && lhs.notes == rhs.notes
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

extension Tuning {
    func closestNote(to frequency: Float) -> Note? {
        self.notes.closest(to: frequency)
    }
}

extension Tuning: Localizable {
    public func localized(to locale: Locale) throws -> Self {
        .init(
            localizationKey: self.localizationKey,
            locale: locale,
            notes: self.notes
        )
    }
}

extension RawRepresentable where Self: CaseIterable, Self.RawValue == Tuning {
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
