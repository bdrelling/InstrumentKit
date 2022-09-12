// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct StringInstrument {
    private static let localizationTableName = "Instruments"

    public let localizationKey: String
    public let name: String
    public let numberOfStrings: Int
    public let numberOfCourses: Int
    public let tunings: [Tuning]
    public let classifications: [HornbostelSachsClassification]
    public let countries: [CountryCode]
    public let year: Int?
    public let aliasedInstrumentKey: String?
    public let resources: [Resource]

    public var standardTuning: Tuning? {
        self.tunings.first { $0.id == Tuning.defaultTuningKey }
    }

    public var alternateTunings: [Tuning] {
        self.tunings.filter { $0.id != Tuning.defaultTuningKey }
    }

    /// The locale used to fetch this instance's localized `String` values.
    /// This property is primarily used for testing and validation.
    public private(set) var locale: Locale = .current

    init(
        localizationKey: String,
        locale: Locale,
        name: String? = nil,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: [Tuning],
        classifications: [HornbostelSachsClassification],
        countries: [CountryCode] = [],
        year: Int? = nil,
        aliasedInstrumentKey: String?,
        resources: [Resource] = []
    ) {
        let name = name ?? Bundle.module.localizedString(for: locale, key: "\(localizationKey).name", table: Self.localizationTableName)

        self.localizationKey = localizationKey
        self.locale = locale
        self.name = name
        self.numberOfStrings = numberOfStrings
        self.numberOfCourses = numberOfCourses
        self.tunings = tunings
        self.classifications = classifications
        self.countries = countries
        self.year = year
        self.aliasedInstrumentKey = aliasedInstrumentKey
        self.resources = resources
    }

    init<Enum>(
        localizationKey: String,
        locale: Locale = .current,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: Enum.Type,
        classifications: [HornbostelSachsClassification],
        countries: [CountryCode] = [],
        year: Int? = nil,
        aliasedInstrumentKey: String? = nil,
        resources: [Resource] = []
    ) where Enum: RawRepresentable, Enum: CaseIterable, Enum.RawValue == Tuning {
        self.init(
            localizationKey: localizationKey,
            locale: locale,
            numberOfStrings: numberOfStrings,
            numberOfCourses: numberOfCourses,
            tunings: tunings.allCases.map(\.rawValue),
            classifications: classifications,
            countries: countries,
            year: year,
            aliasedInstrumentKey: aliasedInstrumentKey,
            resources: resources
        )
    }

    static func alias(
        of aliasedInstrument: Self,
        localizationKey: String,
        locale: Locale = .current,
        countries: [CountryCode]? = nil,
        year: Int? = nil
    ) -> Self {
        .init(
            localizationKey: localizationKey,
            locale: locale,
            numberOfStrings: aliasedInstrument.numberOfStrings,
            numberOfCourses: aliasedInstrument.numberOfCourses,
            tunings: aliasedInstrument.tunings,
            classifications: aliasedInstrument.classifications,
            countries: countries ?? aliasedInstrument.countries,
            year: year ?? aliasedInstrument.year,
            aliasedInstrumentKey: aliasedInstrument.localizationKey,
            resources: aliasedInstrument.resources
        )
    }
}

// MARK: - Supporting Types

public struct Resource: Codable {
    public let key: Key
    public let url: String

    public init(_ key: Key, url: String) {
        self.key = key
        self.url = url
    }
}

public extension Resource {
    enum Key: String, Codable {
        case wikipedia = "Wikipedia"
    }
}

// MARK: - Extensions

extension StringInstrument: Codable {
    enum CodingKeys: String, CodingKey {
        case aliasedInstrumentKey
        case classifications
        case countries
        case localizationKey
        case name
        case numberOfStrings = "strings"
        case numberOfCourses = "courses"
        case resources
        case tunings
        case year
    }
}

extension StringInstrument: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localizationKey == rhs.localizationKey
            && lhs.numberOfStrings == rhs.numberOfStrings
            && lhs.numberOfCourses == rhs.numberOfCourses
            && lhs.tunings == rhs.tunings
    }
}

extension StringInstrument: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
}

extension StringInstrument: Identifiable {
    public var id: String {
        self.localizationKey
    }
}

extension StringInstrument: Localizable {
    public func localized(to locale: Locale) -> Self {
        .init(
            localizationKey: self.localizationKey,
            locale: locale,
            numberOfStrings: self.numberOfStrings,
            numberOfCourses: self.numberOfCourses,
            tunings: self.tunings,
            classifications: self.classifications,
            countries: self.countries,
            year: self.year,
            aliasedInstrumentKey: self.aliasedInstrumentKey,
            resources: self.resources
        )
    }
}
