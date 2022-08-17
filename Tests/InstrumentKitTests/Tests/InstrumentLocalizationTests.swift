// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
@testable import InstrumentKit
import XCTest

final class InstrumentLocalizationTests: XCTestCase {
    func testLocalizationSucceeds() throws {
        let englishInstruments = try StringInstrumentCollection()
        let spanishInstruments = try StringInstrumentCollection(languageCode: "es")

        try self.compare(englishInstruments: englishInstruments, spanishInstruments: spanishInstruments)
    }

    func testRelocalizationSucceeds() throws {
        let englishInstruments = try StringInstrumentCollection()
        let spanishInstruments = try englishInstruments.localized(to: "es")

        try self.compare(englishInstruments: englishInstruments, spanishInstruments: spanishInstruments)
    }

    func testLocalizationDoesNotExist() throws {
        do {
            let _ = try StringInstrumentCollection(languageCode: "xx")
            XCTFail("Localalization project should not exist.")
        } catch LocalizationError.projectNotFound {
            // do nothing -- the correct error was thrown
        } catch {
            // re-surface other errors
            throw error
        }
    }

    private func compare(englishInstruments: StringInstrumentCollection, spanishInstruments: StringInstrumentCollection) throws {
        // The collections should be equal.
        XCTAssertEqual(englishInstruments, spanishInstruments)

        let guitar = try XCTUnwrap(englishInstruments.first)
        let guitarra = try XCTUnwrap(spanishInstruments.first)

        // The instruments should be equal.
        XCTAssertEqual(guitar, guitarra)

        // But the instrument names should not match.
        XCTAssertNotEqual(guitar.name.value, guitarra.name.value)
    }
}
