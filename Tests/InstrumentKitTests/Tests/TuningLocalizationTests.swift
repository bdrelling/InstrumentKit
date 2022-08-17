// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
@testable import InstrumentKit
import XCTest

final class TuningLocalizationTests: XCTestCase {
    func testLocalizationSucceeds() throws {
        let englishTunings = try TuningCollection(instrument: .guitar)
        let spanishTunings = try TuningCollection(instrument: .guitar, languageCode: "es")

        try self.compare(englishTunings: englishTunings, spanishTunings: spanishTunings)
    }

    func testRelocalizationSucceeds() throws {
        let englishTunings = try TuningCollection(instrument: .guitar)
        let spanishTunings = try englishTunings.localized(to: "es")

        try self.compare(englishTunings: englishTunings, spanishTunings: spanishTunings)
    }

    func testLocalizationDoesNotExist() throws {
        do {
            let _ = try TuningCollection(instrument: .guitar, languageCode: "xx")
            XCTFail("Localalization project should not exist.")
        } catch LocalizationError.projectNotFound {
            // do nothing -- the correct error was thrown
        } catch {
            // re-surface other errors
            throw error
        }
    }

    private func compare(englishTunings: TuningCollection, spanishTunings: TuningCollection) throws {
        // The collections should be equal.
        XCTAssertEqual(englishTunings, spanishTunings)

        let standard = try XCTUnwrap(englishTunings.tunings.first)
        let estandar = try XCTUnwrap(spanishTunings.tunings.first)

        // The collections should be equal.
        XCTAssertEqual(standard, estandar)

        // But the instrument names should not match.
        XCTAssertNotEqual(standard.name.value, estandar.name.value)
    }
}
