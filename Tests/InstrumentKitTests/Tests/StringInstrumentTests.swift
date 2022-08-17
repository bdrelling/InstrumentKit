// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import InstrumentKit
import NoteKit
import XCTest

final class StringInstrumentTests: XCTestCase {
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()

    func testAllLocalizationKeysAreUnique() {
        let localizationKeys = StringInstrument.allCases.map(\.localizationKey)
        XCTAssertEqual(localizationKeys.count, Set(localizationKeys).count)
    }

    func testAllInstrumentsTuningsAreValid() throws {
        // Iterate through all instruments and ensure that their tunings are valid.
        for instrument in StringInstrument.allCases {
            for tuning in instrument.tunings {
                // Tunings should have the correct number of strings.
                XCTAssertEqual(tuning.notes.count, instrument.numberOfStrings, "Tuning \(tuning) has an invalid number of strings.")
            }

            // Ensure all tunings for the instrument have unique localization keys.
            let localizationKeys = instrument.tunings.map(\.localizationKey)
            XCTAssertEqual(localizationKeys.count, Set(localizationKeys).count)

            // Ensure no tunings evaluate as a duplicate.
            XCTAssertEqual(instrument.tunings.count, Set(instrument.tunings).count)
        }
    }
}

// MARK: - Extensions

extension StringInstrumentTests: SerializationTesting {
    func testEncodingAndDecodingSucceeds() throws {
        try self.reserializeAndCompare(StringInstrument.guitar)
    }
}
