// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct StringInstrument: Equatable {
    static let cache = StringInstrumentCache(filename: "string_instruments", fileExtension: "yml")

    public let name: LocalizedInstrumentName
    public let numberOfStrings: Int
    public let numberOfCourses: Int

    public lazy var tunings: [Tuning] = {
        (try? TuningCollection(instrument: self.name).tunings) ?? []
    }()

    public init(name: LocalizedInstrumentName, numberOfStrings: Int, numberOfCourses: Int) {
        self.name = name
        self.numberOfStrings = numberOfStrings
        self.numberOfCourses = numberOfCourses
    }

    public init(name: String, numberOfStrings: Int, numberOfCourses: Int) {
        self.init(name: .init(value: name), numberOfStrings: numberOfStrings, numberOfCourses: numberOfCourses)
    }

    public init(name: LocalizedInstrumentName) throws {
        guard let instrument = try Self.cache.get().first(where: { $0.name == name }) else {
            throw InstrumentKitError.invalidInstrument(name)
        }

        self = try instrument.localized(to: name.locale)
    }
}

// MARK: - Supporting Types

public typealias LocalizedInstrumentName = LocalizedText<InstrumentsTableKey>

public struct InstrumentsTableKey: LocalizedTableKey {
    public static let tableName = "Instruments"
}

public extension StringInstrument {
    enum Key: String, Codable, Equatable {
        case guitar = "Guitar"
        case bass = "Bass"
        case ukulele = "Ukulele"
    }
}

// MARK: - Extensions

extension StringInstrument: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case numberOfStrings = "strings"
        case numberOfCourses = "courses"
    }
}

extension StringInstrument: Identifiable {
    public var id: String {
        self.name.key
    }
}

extension StringInstrument: Localizable {
    public func localized(to locale: Locale) throws -> Self {
        .init(
            name: try self.name.localized(to: locale),
            numberOfStrings: self.numberOfStrings,
            numberOfCourses: self.numberOfCourses
        )
    }
}
