// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct StringInstrument {
    private static let localizationTableName = "Instruments"

    public let localizationKey: String
    public let locale: Locale
    public let name: String
    public let numberOfStrings: Int
    public let numberOfCourses: Int
    public let tunings: [Tuning]

    private init(localizationKey: String, locale: Locale = .current, name: String, numberOfStrings: Int, numberOfCourses: Int, tunings: [Tuning]) {
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

    public init(name: String, numberOfStrings: Int, numberOfCourses: Int, tunings: [Tuning]) {
        self.init(localizationKey: name, name: name, numberOfStrings: numberOfStrings, numberOfCourses: numberOfCourses, tunings: tunings)
    }
}

// MARK: - Extensions

extension StringInstrument: Codable {
    enum CodingKeys: String, CodingKey {
        case localizationKey
        case locale
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
