// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import InstrumentKit
import NoteKit
import XCTest

final class TuningTests: XCTestCase {
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()

    func testAllTuningsAreValid() throws {
        for tuning in Tuning.allCases {
            // The name should not contain "error", which would indicate a parsing failure.
            XCTAssertFalse(tuning.name.contains("error"), "Tuning \(tuning) has an invalid name.")

            // The notes array should be populated.
            XCTAssertFalse(tuning.notes.isEmpty, "Tuning \(tuning) has an empty notes array.")
        }
    }

    func testGuitarStandardTuning() {
        let tuning: Tuning = .Guitar.standard.rawValue

        let noteClasses = tuning.notes.map(\.noteClass)
        XCTAssertEqual(noteClasses, [
            .e, // E2
            .a, // A2
            .d, // D3
            .g, // G3
            .b, // B3
            .e, // E4
        ])

        let octaves = tuning.notes.map(\.octave.rawValue)
        XCTAssertEqual(octaves, [
            2, // E2
            2, // A2
            3, // D3
            3, // G3
            3, // B3
            4, // E4
        ])

        let frequencies = tuning.notes.map(\.frequency)
        XCTAssertEqual(frequencies, [
            82.41, // E2
            110.0, // A2
            146.83, // D3
            196.0, // G3
            246.94, // B3
            329.63, // E4
        ])
    }

    func testStringLiteralInitializationSucceeds() throws {
        let tuning: Tuning = "standard: A1 B2 C3 D4"

        XCTAssertEqual(tuning.localizationKey, "standard")
        XCTAssertEqual(tuning.locale, .current)
        XCTAssertEqual(tuning.name, "Standard")
        XCTAssertEqual(tuning.notes, [.a(1), .b(2), .c(3), .d(4)])
    }
}

extension TuningTests: SerializationTesting {
    func testEncodingAndDecodingSucceeds() throws {
        try self.reserializeAndCompare(Tuning.Guitar.standard.rawValue)
    }
}
