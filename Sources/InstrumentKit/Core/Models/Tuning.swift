// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import NoteKit

public struct Tuning: Equatable {
    static let cache = TuningCache(filename: "tunings", fileExtension: "yml")
    private static let defaultTuningName = "Standard"

    public let name: LocalizedTuningName
    public let notes: [Note]

    public init(name: LocalizedTuningName, notes: [Note]) {
        self.name = name
        self.notes = notes
    }

    public init(name: LocalizedTuningName, notes: Note...) {
        self.init(name: name, notes: notes)
    }

    public init(name: String, notes: [Note]) {
        self.init(name: .init(value: name), notes: notes)
    }

    public init(name: String, notes: Note...) {
        self.init(name: name, notes: notes)
    }

    public init(instrument: LocalizedInstrumentName, tuning: LocalizedTuningName) throws {
        guard let tunings = try Self.cache.get().first(where: { $0.instrumentName == instrument }) else {
            throw InstrumentKitError.invalidInstrument(instrument)
        }

        guard let tuning = tunings.first(where: { $0.name == tuning }) else {
            throw InstrumentKitError.invalidTuning(tuning)
        }

        self = try tuning.localized(to: instrument.locale)
    }
}

// MARK: - Supporting Types

public typealias LocalizedTuningName = LocalizedText<TuningsTableKey>

public struct TuningsTableKey: LocalizedTableKey {
    public static let tableName = "Tunings"
}

// MARK: - Extensions

extension Tuning: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(LocalizedText.self, forKey: .name)

        do {
            self.notes = try container.decode([Note].self, forKey: .notes)
        } catch {
            let rawNotesString = try container.decode(String.self, forKey: .notes)
            self.notes = .init(rawValue: rawNotesString)
        }
    }
}

extension Tuning: Identifiable {
    public var id: String {
        self.name.key
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
            name: try self.name.localized(to: locale),
            notes: self.notes
        )
    }
}

// MARK: - Convenience

public extension LocalizedTuningName {
    static let standard: Self = .init(value: "Standard")
}
