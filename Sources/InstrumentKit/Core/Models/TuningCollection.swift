// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import NoteKit
import Yams

public struct TuningCollection: Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case instrumentName = "instrument"
        case tunings
    }

    public let instrumentName: LocalizedInstrumentName
    public let tunings: [Tuning]
}

// MARK: - Supporting Types

public enum TuningCollectionError: LocalizedError {
    case invalidInstrument(LocalizedInstrumentName)

    public var errorDescription: String? {
        switch self {
        case let .invalidInstrument(instrument):
            return "Invalid instrument '\(instrument)'."
        }
    }
}

// MARK: - Extensions

public extension TuningCollection {
    init(instrument: LocalizedInstrumentName) throws {
        guard let tunings = try Tuning.cache.get()
            .first(where: { $0.instrumentName == instrument })
        else {
            throw TuningCollectionError.invalidInstrument(instrument)
        }

        self = try tunings.localized(to: instrument.locale)
    }

    init(instrument: LocalizedInstrumentName, locale: Locale) throws {
        try self.init(instrument: instrument.localized(to: locale))
    }

    init(instrument: LocalizedInstrumentName, languageCode: String) throws {
        try self.init(instrument: instrument.localized(to: languageCode))
    }
}

// MARK: - Extensions

extension TuningCollection: Collection {
    public typealias Index = Int
    public typealias Element = Tuning

    public var startIndex: Index { self.tunings.startIndex }
    public var endIndex: Index { self.tunings.endIndex }

    public subscript(index: Index) -> Iterator.Element {
        self.tunings[index]
    }

    public func index(after i: Index) -> Index {
        self.tunings.index(after: i)
    }
}

extension TuningCollection: Localizable {
    public func localized(to locale: Locale) throws -> Self {
        .init(
            instrumentName: self.instrumentName,
            tunings: try self.tunings.localized(to: locale)
        )
    }
}

// MARK: - Convenience

public extension TuningCollection {
    static let empty: Self = .init(instrumentName: "Empty", tunings: [])
}
