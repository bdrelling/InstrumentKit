// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
@testable import InstrumentKit
import XCTest

final class TuningLocalizationTests: XCTestCase {
    func testLocalizationSucceeds() {
        let english = Tuning.Guitar.standard.rawValue
        let spanish = Tuning.Guitar.standard.rawValue.localized(to: "es")

        // They should evaluate to equal.
        XCTAssertEqual(english, spanish)

        // But the names and localizations should not match.
        XCTAssertNotEqual(english.name, spanish.name)
        XCTAssertNotEqual(english.locale, spanish.locale)
    }

    func testMissingLocalizationSucceeds() {
        let english = Tuning.Guitar.standard.rawValue
        let missing = Tuning.Guitar.standard.rawValue.localized(to: "xx")

        // They should evaluate to equal.
        XCTAssertEqual(english, missing)

        // The names should match, since there is no "xx" localization.
        XCTAssertEqual(english.name, missing.name)

        // But the localizations should be different, since Foundation creations an "xx (fixed)" localization.
        XCTAssertNotEqual(english.locale, missing.locale)
    }

    func testAllLocalizationsExist() {
        self.validate()
    }
}

// MARK: - Extensions

private extension TuningLocalizationTests {
    func validate(localeIdentifier: String) {
        for tuning in Tuning.allCases.localized(to: localeIdentifier) {
            // The name should not contain the localization key,
            // which would imply that the name could not be localized.
            XCTAssertFalse(tuning.name.contains(tuning.localizationKey), "Tuning \(tuning) is not properly localized for identifier \(localeIdentifier).")
        }
    }

    func validate(localeIdentifiers: [String] = SupportedLanguage.allCases.map(\.rawValue)) {
        localeIdentifiers.forEach(self.validate)
    }
}
