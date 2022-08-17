// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct StringInstrument {
    private static let localizationTableName = "Instruments"

    public let localizationKey: String
    public let name: String
    public let numberOfStrings: Int
    public let numberOfCourses: Int
    public let tunings: [Tuning]

    /// The locale used to fetch this instance's localized `String` values.
    /// This property is primarily used for testing and validation.
    public private(set) var locale: Locale?

    private init(localizationKey: String, locale: Locale?, name: String, numberOfStrings: Int, numberOfCourses: Int, tunings: [Tuning]) {
        self.localizationKey = localizationKey
        self.locale = locale
        self.name = name
        self.numberOfStrings = numberOfStrings
        self.numberOfCourses = numberOfCourses
        self.tunings = tunings
    }

    public init(localizationKey: String, locale: Locale = .current, numberOfStrings: Int, numberOfCourses: Int, tunings: [Tuning]) {
        let name = Bundle.module.localizedString(for: locale, key: "\(localizationKey).name", table: Self.localizationTableName)

        self.init(localizationKey: localizationKey, locale: locale, name: name, numberOfStrings: numberOfStrings, numberOfCourses: numberOfCourses, tunings: tunings)
    }

    public init<Enum>(
        localizationKey: String,
        locale: Locale = .current,
        numberOfStrings: Int,
        numberOfCourses: Int,
        tunings: Enum.Type
    ) where Enum: RawRepresentable, Enum: CaseIterable, Enum.RawValue == Tuning {
        self.init(
            localizationKey: localizationKey,
            locale: locale,
            numberOfStrings: numberOfStrings,
            numberOfCourses: numberOfCourses,
            tunings: tunings.allCases.map(\.rawValue)
        )
    }

    /// Creates an unlocalized and unlocalizable instance, typically for purposes like mocking.
    public init(name: String, numberOfStrings: Int, numberOfCourses: Int, tunings: [Tuning]) {
        self.init(localizationKey: name, locale: nil, name: name, numberOfStrings: numberOfStrings, numberOfCourses: numberOfCourses, tunings: tunings)
    }
}

// MARK: - Extensions

extension StringInstrument: Codable {
    enum CodingKeys: String, CodingKey {
        case localizationKey
        case name
        case numberOfStrings = "strings"
        case numberOfCourses = "courses"
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
            tunings: self.tunings
        )
    }
}
