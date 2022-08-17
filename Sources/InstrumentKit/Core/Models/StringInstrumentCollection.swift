// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import NoteKit
import Yams

public struct StringInstrumentCollection: Equatable {
    public let instruments: [StringInstrument]
}

// MARK: - Extensions

public extension StringInstrumentCollection {
    init(locale: Locale? = nil) throws {
        let instruments = try StringInstrument.cache.get()

        if let locale = locale {
            self = try .init(instruments: instruments.localized(to: locale))
        } else {
            self = .init(instruments: instruments)
        }
    }

    init(languageCode: String) throws {
        try self.init(locale: .init(identifier: languageCode))
    }
}

extension StringInstrumentCollection: Collection {
    public typealias Index = Int
    public typealias Element = StringInstrument

    public var startIndex: Index { self.instruments.startIndex }
    public var endIndex: Index { self.instruments.endIndex }

    public subscript(index: Index) -> Iterator.Element {
        self.instruments[index]
    }

    public func index(after i: Index) -> Index {
        self.instruments.index(after: i)
    }
}

extension StringInstrumentCollection: ExpressibleByArrayLiteral {
    public init(arrayLiteral instruments: Element...) {
        self.instruments = instruments
    }
}

extension StringInstrumentCollection: Localizable {
    public func localized(to locale: Locale) throws -> Self {
        .init(
            instruments: try self.instruments.localized(to: locale)
        )
    }
}

// MARK: - Convenience

public extension StringInstrumentCollection {
    static let empty: Self = []
}
