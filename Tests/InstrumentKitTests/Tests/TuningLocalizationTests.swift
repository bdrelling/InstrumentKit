// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
@testable import InstrumentKit
import XCTest

final class TuningLocalizationTests: XCTestCase {
    func testLocalizationSucceeds() throws {
        let english = Tuning.guitar.standard
        let spanish = try Tuning.guitar.standard.localized(to: "es")

        // They should evaluate to equal.
        XCTAssertEqual(english, spanish)

        // But the names and localizations should not match.
        XCTAssertNotEqual(english.name, spanish.name)
        XCTAssertNotEqual(english.locale, spanish.locale)
    }

    func testMissingLocalizationSucceeds() throws {
        let english = Tuning.guitar.standard
        let missing = try Tuning.guitar.standard.localized(to: "xx")

        // They should evaluate to equal.
        XCTAssertEqual(english, missing)

        // The names should match, since there is no "xx" localization.
        XCTAssertEqual(english.name, missing.name)

        // But the localizations should be different, since Foundation creations an "xx (fixed)" localization.
        XCTAssertNotEqual(english.locale, missing.locale)
    }
}
