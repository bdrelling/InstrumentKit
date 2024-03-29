// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation
@testable import InstrumentKit
import XCTest

final class StringInstrumentLocalizationTests: XCTestCase {
    func testLocalizationSucceeds() {
        let english = StringInstrument.guitar
        let spanish = StringInstrument.guitar.localized(to: "es")

        // They should evaluate to equal.
        XCTAssertEqual(english, spanish)

        // But the names and localizations should not match.
        XCTAssertNotEqual(english.name, spanish.name)
        XCTAssertNotEqual(english.locale, spanish.locale)
    }

    func testMissingLocalizationSucceeds() {
        let english = StringInstrument.guitar
        let missing = StringInstrument.guitar.localized(to: "xx")

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

private extension StringInstrumentLocalizationTests {
    func validate(localeIdentifier: String) {
        for instrument in StringInstrument.allCases.localized(to: localeIdentifier) {
            // The name should not contain the localization key,
            // which would imply that the name could not be localized.
            XCTAssertFalse(instrument.name.contains(instrument.localizationKey), "Instrument \(instrument) is not properly localized.")
        }
    }

    func validate(localeIdentifiers: [String] = SupportedLanguage.allCases.map(\.rawValue)) {
        localeIdentifiers.forEach(self.validate)
    }
}
