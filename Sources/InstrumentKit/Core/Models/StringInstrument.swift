// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct StringInstrument {
    private static let localizationTableName = "Instruments"

    public let localizationKey: String
    public let name: String
    public let numberOfStrings: Int
    public let numberOfCourses: Int
    public let tunings: [Tuning]
    public let resources: [SourceKey: String]

    /// The locale used to fetch this instance's localized `String` values.
    /// This property is primarily used for testing and validation.
    public private(set) var locale: Locale?

    private init(
        localizationKey: String,
        locale: Locale,
        name: String,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: [Tuning],
        resources: [SourceKey: String]
    ) {
        self.localizationKey = localizationKey
        self.locale = locale
        self.name = name
        self.numberOfStrings = numberOfStrings
        self.numberOfCourses = numberOfCourses
        self.tunings = tunings
        self.resources = resources
    }

    init(
        localizationKey: String,
        locale: Locale = .current,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: [Tuning],
        resources: [SourceKey: String]
    ) {
        let name = Bundle.module.localizedString(for: locale, key: "\(localizationKey).name", table: Self.localizationTableName)

        self.init(
            localizationKey: localizationKey,
            locale: locale,
            name: name,
            numberOfStrings: numberOfStrings,
            numberOfCourses: numberOfCourses,
            tunings: tunings,
            resources: resources
        )
    }

    /// Creates an unlocalized and unlocalizable instance, typically for purposes like mocking.
    init(
        name: String,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: [Tuning],
        resources: [SourceKey: String] = [:]
    ) {
        self.init(
            localizationKey: name,
            locale: .current,
            name: name,
            numberOfStrings: numberOfStrings,
            numberOfCourses: numberOfCourses,
            tunings: tunings,
            resources: resources
        )
    }

    init<Enum>(
        localizationKey: String,
        locale: Locale = .current,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: Enum.Type,
        resources: [SourceKey: String] = [:]
    ) where Enum: RawRepresentable, Enum: CaseIterable, Enum.RawValue == Tuning {
        self.init(
            localizationKey: localizationKey,
            locale: locale,
            numberOfStrings: numberOfStrings,
            numberOfCourses: numberOfCourses,
            tunings: tunings.allCases.map(\.rawValue),
            resources: resources
        )
    }
}

// MARK: - Supporting Types

public enum SourceKey: String, Codable {
    case wikipedia = "Wikipedia"
}

// MARK: - Extensions

extension StringInstrument: Codable {
    enum CodingKeys: String, CodingKey {
        case localizationKey
        case name
        case numberOfStrings = "strings"
        case numberOfCourses = "courses"
        case resources
        case tunings
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
            resources: self.resources
        )
    }
}
